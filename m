From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:46:04 -0700
Subject: [PATCH v4 06/19] AppArmor: Abstract use of cred security blob
In-Reply-To: <e9eb2c69-5175-d033-cb38-1cc84cf55bfe@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<e9eb2c69-5175-d033-cb38-1cc84cf55bfe@schaufler-ca.com>
Message-ID: <CAGXu5jLpNvSSaJb=zPQfCq_wwBRnf3BXafZt9UHDdjK7JotbiA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
