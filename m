From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:56:55 -0700
Subject: [PATCH v4 16/19] SELinux: Abstract use of ipc security blobs
In-Reply-To: <383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<383f1b1a-3d7c-46d2-a553-3a09f25bc1c4@schaufler-ca.com>
Message-ID: <CAGXu5jJ1dNrxLetD=t=PX3pJNKigjdj+CSHMfNF6cePQmYYwag@mail.gmail.com>
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
