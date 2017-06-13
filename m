From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 13 Jun 2017 09:50:06 +0200
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <20170612193826.GA4235@kroah.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
	<20170612193826.GA4235@kroah.com>
Message-ID: <CAJHCu1+P798ip7qMTdu6SrKnSg4+0kFzyQb1gqGT31ih5atGKA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-12 21:38 GMT+02:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> No, like Krzysztof said, you can already do this today, just fine, from
> userspace.  I think that support has been there for over a decade now,
> why are you not taking advantage of this already?
> No need to add extra stuff to the kernel at all to do this

Honesty, now that you mention it, I agree with you.
This feature can be implemented in userspace and I'm the first one to
think that what can be implemented in userspace should stay in
userspace.

> sorry you
> implemented all of this for no reason :(

Don't worry, usb filtering is just a small part of this patchset.
Let's hope the rest will end up being more useful. :)

Thank you very much for taking the time to answer me.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
