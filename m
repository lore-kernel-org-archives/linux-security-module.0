From: steve@steve.org.uk (Steve Kemp)
Date: Thu, 22 Jun 2017 08:09:15 +0000
Subject: [PATCH] Moved module init-functions into the module.
In-Reply-To: <CABawtvN4qFQ7BEB1xYBi1Vw8Sg1=xHMF2TVnnKVGcYXwerZLgQ@mail.gmail.com>
References: <20170622065540.GA32346@steve.org.uk>
	<CABawtvN4qFQ7BEB1xYBi1Vw8Sg1=xHMF2TVnnKVGcYXwerZLgQ@mail.gmail.com>
Message-ID: <20170622080915.GA2936@steve.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu Jun 22, 2017 at 16:02:30 +0800, Ethan Zhao wrote:

>       Seems you moved the initialization of security module to
> late_initcall stage, that is not right.

  Thanks for the feedback.

>       For security modules, you should use security_initcall() macro to define
> the init functions.

  Literally just a change like this?

  -late_initcall(yama_add_hooks);
  +security_initcall(yama_add_hooks);

  I'll submit v2 with that shortly, thanks.

Steve
-- 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
