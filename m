From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 13 Jun 2017 09:43:16 +0200
Subject: [kernel-hardening] [PATCH 01/11] S.A.R.A. Documentation
In-Reply-To: <CAG48ez1DBG9cwGtcwKmrL9tSfi4vvNk-X07jnUmzv81RM4Po_Q@mail.gmail.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-2-git-send-email-s.mesoraca16@gmail.com>
	<CAG48ez1DBG9cwGtcwKmrL9tSfi4vvNk-X07jnUmzv81RM4Po_Q@mail.gmail.com>
Message-ID: <CAJHCu1JGyW6AasQ=VSLDVv9S2u7mf9SxgGX8H7KBnjHKvfsjkA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-12 19:49 GMT+02:00 Jann Horn <jannh@google.com>:
> On Mon, Jun 12, 2017 at 6:56 PM, Salvatore Mesoraca
> As far as I can tell, the wxprot interface in procfs, when used as
> /proc/PID/attr/sara/wxprot, actually only sets restrictions on one of the
> threads.
> The documentation doesn't seem to mention this.

Yes, you are right. I'll change it.

>> +.. [3] `saralib                <https://github.com/smeso/saralib>`_
>
> This link is broken.

Oops, the correct link is https://github.com/smeso/libsara

Thank you very much for your time.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
