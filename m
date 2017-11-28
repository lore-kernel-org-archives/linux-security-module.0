From: keescook@chromium.org (Kees Cook)
Date: Tue, 28 Nov 2017 13:39:58 -0800
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171128211659.GP729@wotan.suse.de>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-2-git-send-email-tixxdz@gmail.com>
	<20171128191405.GO729@wotan.suse.de>
	<CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
	<20171128211659.GP729@wotan.suse.de>
Message-ID: <CAGXu5j+JaFCo+pZKvet==Kh7GQgNXi30P50SMF4cpOGoUw-8ug@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 1:16 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> And *all* auto-loading uses aliases? What's the difference between auto-loading
> and direct-loading?

The difference is the process privileges. Unprivilged autoloading
(e.g. int n_hdlc = N_HDLC; ioctl(fd,
TIOCSETD, &n_hdlc)), triggers a privileged call to finit_module()
under CAP_SYS_MODULE.

>> We already have a global sysctl for blocking direct-loading (modules_disabled).
>
> My point was that even if you have a CAP_NET_ADMIN check on request_module(),
> finit_module() will not check for it, so a crafty userspace could still try
> to just finit_module() directly, and completely then bypass the CAP_NET_ADMIN
> check.

You need CAP_SYS_MODULE to run finit_module().

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
