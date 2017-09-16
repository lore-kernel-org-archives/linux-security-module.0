From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Sat, 16 Sep 2017 14:40:24 +0200
Subject: [PATCH] security: keys: switch big_key encryption to AES in CTR
	mode
In-Reply-To: <20170916024753.GA6901@zzz.localdomain>
References: <20170915223723.20789-1-ard.biesheuvel@linaro.org>
	<20170916024753.GA6901@zzz.localdomain>
Message-ID: <CAHmME9pP72SSFiEPmH4VhQcoVyWcHK2p402+EbzEd0WepnA1qQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hey Eric,

Thanks for adding me to the CC.

On Sep 16, 2017 05:14, "Eric Biggers" <ebiggers3@gmail.com> wrote:
> There was a
> patch a few months ago that implemented this and fixed a couple other problems,
> but it hasn't been merged; maybe someone wants to take over that patch instead?
> Link: http://lkml.kernel.org/r/20170607101209.7603-1-Jason at zx2c4.com

I didn't realize this patch wasn't merged and was eventually
neglected. (I wonder how many other of my patches have met this
fate...) I'll take another look at it this week and resubmit (and
possibly tweek if needed).

Regards,
Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
