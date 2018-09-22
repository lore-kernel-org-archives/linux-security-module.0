From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:51:38 -0700
Subject: [PATCH v4 10/19] Smack: Abstract use of file security blob
In-Reply-To: <bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<bd7c5604-ebb1-b42b-cf29-589494dbb1c5@schaufler-ca.com>
Message-ID: <CAGXu5jL6YoxzA18dL7zG3YDefAQTX5jh6=VDRGv536AotZdh+A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the file->f_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
