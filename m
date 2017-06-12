From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 12 Jun 2017 19:32:30 +0200 (CEST)
Subject: [PATCH 08/11] Creation of "pagefault_handler_x86" LSM hook
In-Reply-To: <1497286620-15027-9-git-send-email-s.mesoraca16@gmail.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-9-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <alpine.DEB.2.20.1706121929430.1911@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 12 Jun 2017, Salvatore Mesoraca wrote:
> Creation of a new hook to let LSM modules handle user-space pagefaults on
> x86.
> It can be used to avoid segfaulting the originating process.
> If it's the case it can modify process registers before returning.

That explains, what you could do with it, but it completely lacks any
rationale WHY this is desired and good behaviour and how that is a security
feature.

Thanks,

	tglx

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
