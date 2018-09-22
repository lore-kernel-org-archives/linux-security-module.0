From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:47:03 -0700
Subject: [PATCH v4 07/19] TOMOYO: Abstract use of cred security blob
In-Reply-To: <8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<8ea966f7-924e-b805-56e8-9ad74e7f9d86@schaufler-ca.com>
Message-ID: <CAGXu5jKRmACSA0kdG1v==zaaNxh=K9ePi4TVFfD3Zq-vOChVfg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide helper functions that provide the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
