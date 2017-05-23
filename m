From: keescook@google.com (Kees Cook)
Date: Tue, 23 May 2017 11:36:36 -0700
Subject: [kernel-hardening] [PATCH v4 next 0/3] modules: automatic module
	loading restrictions
In-Reply-To: <20170523074808.GA4562@openwall.com>
References: <1495454226-10027-1-git-send-email-tixxdz@gmail.com>
	<20170522120848.GA3003@openwall.com>
	<CAEiveUdqfMk4+vLg6TaEJNSGwoQHxYq0P4aqZoL4i9GgR3Vdtw@mail.gmail.com>
	<20170522164323.GA2048@openwall.com>
	<CAEiveUdb=yc5Gt_+pU_hfNdoNBP0JsUL1QUydNZgc2tD7n1h1w@mail.gmail.com>
	<CAGXu5jKGnG74KE-k9JPaH1bNqT5nbVioaeu_5sAKQ+4kgp-0Ng@mail.gmail.com>
	<20170523074808.GA4562@openwall.com>
Message-ID: <CAGXu5jJ-zpqU9v44=bc0GnQP5zcKtceR_7DBQVBZ=vy3OvNx9w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 23, 2017 at 12:48 AM, Solar Designer <solar@openwall.com> wrote:
> For modules_autoload_mode=2, we already seem to have the equivalent of
> modprobe=/bin/true (or does it differ subtly, maybe in return values?),
> which I already use at startup on a GPU box like this (preloading
> modules so that the OpenCL backends wouldn't need the autoloading):
>
> nvidia-smi
> nvidia-modprobe -u -c=0
> #modprobe nvidia_uvm
> #modprobe fglrx
>
> sysctl -w kernel.modprobe=/bin/true
> sysctl -w kernel.hotplug=/bin/true
>
> but it's good to also have this supported more explicitly and more
> consistently through modules_autoload_mode=2 while we're at it.  So I
> support having this mode as well.  I just question the need to have it
> non-resettable.

I agree it's useful to have the explicit =2 state just to avoid
confusion when more systems start implementing
CONFIG_STATIC_USERMODEHELPER and kernel.modprobe becomes read-only
(though the userspace implementation may allow for some way to disable
it, etc). I just like avoiding the upcall to modprobe at all.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
