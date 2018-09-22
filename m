From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Sep 2018 19:43:41 -0700
Subject: [PATCH v4 05/19] SELinux: Remove unused selinux_is_enabled
In-Reply-To: <c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
	<c7a864e4-1297-2973-9d4c-7c855a20a06d@schaufler-ca.com>
Message-ID: <CAGXu5jLaS++iur+Pwnjr8qMFgsAun9mV5O43OiKEy-bAF3gG9A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 21, 2018 at 5:17 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> There are no longer users of selinux_is_enabled().
> Remove it. As selinux_is_enabled() is the only reason
> for include/linux/selinux.h remove that as well.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
