From: aranea@aixah.de (Luis Ressel)
Date: Wed, 21 Jun 2017 11:48:12 +0200
Subject: [PATCH] selinux: Assign proper class to PF_UNIX/SOCK_RAW sockets
In-Reply-To: <CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
References: <20170619213348.2970-1-aranea@aixah.de>
	<CAHC9VhQsVa+0LgqFyguqq0bhXOz7mrbJfXy-+rJjY53xnCkixg@mail.gmail.com>
	<1497989063.12069.18.camel@tycho.nsa.gov>
	<CAHC9VhTz2uFMAcYBCph1=XVtib1owCuSi+c1stQsxkymDt_BJQ@mail.gmail.com>
Message-ID: <20170621114812.6aa3f62e@vega.skynet.aixah.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 20 Jun 2017 17:43:38 -0400
Paul Moore <paul@paul-moore.com> wrote:

> Considering where we are at with respect to the merge window, let's
> shelve this for now and I'll merge it after the next merge window
> closes.  In all likelihood I'll be sending selinux/next up to James
> later this week and I'd like this to sit in linux-next for longer than
> a few days.

That means the change will land in 4.14 at the earliest, right? (Just
out of curiosity.)

By the way, refpolicy only grants "socket" permissions to a handful of
domains, all of which also have the corresponding "unix_dgram_socket"
permissions. The fedora policy does the same (according to Stephen);
this only leaves custom policies to be potentially affected by this
change.

Given that the SOCK_RAW->SOCK_DGRAM translation is obscure enough not to
be documented anywhere outside the kernel sources, I doubt there are
many users of it, anyway.

Regards,
Luis Ressel
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
