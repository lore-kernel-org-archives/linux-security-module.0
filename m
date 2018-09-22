From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:57:27 -0700
Subject: [PATCH v4 17/19] Smack: Abstract use of ipc security blobs
In-Reply-To: <f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<f8d020ad-2e50-d541-3187-81f63557f667@schaufler-ca.com>
Message-ID: <CAGXu5jL6GAWmCAt1aXdVvr9HqdUUOynJ4Ma1VBGjjdTkyNb+qQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the ipc->security pointer directly.
> Don't use the msg_msg->security pointer directly.
> Provide helper functions that provides the security blob pointers.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
