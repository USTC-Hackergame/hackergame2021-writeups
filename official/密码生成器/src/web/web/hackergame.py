import OpenSSL
import base64
from django.shortcuts import redirect, render

with open("./cert.pem") as f:
    cert = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, f.read())


class TokenCheckMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        # One-time configuration and initialization.

    def __call__(self, request):
        # Code to be executed for each request before
        # the view (and later middleware) are called.

        if not request.path.startswith("/static/"):
            if request.GET.get("token"):
                try:
                    token = request.GET.get("token")
                    id, sig = token.split(":", 1)
                    sig = base64.b64decode(sig, validate=True)
                    OpenSSL.crypto.verify(cert, sig, id.encode(), "sha256")
                    request.session["token"] = token
                except Exception:
                    request.session["token"] = None
                return redirect("index")
            if request.session.get("token") is None:
                return render(request, "error.html", status=403)

        response = self.get_response(request)

        # Code to be executed for each request/response after
        # the view is called.

        return response
