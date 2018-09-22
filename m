From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:44:34 -0700
Subject: [PATCH v4 02/19] Smack: Abstract use of cred security blob
In-Reply-To: <03191752-22d3-4066-3d3a-8fbe209447e5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<03191752-22d3-4066-3d3a-8fbe209447e5@schaufler-ca.com>
Message-ID: <CAGXu5jJMEwAtns_L79WF+CrpYnOBZxCvZi_xnHHVDMVB18_PNQ@mail.gmail.com>
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
