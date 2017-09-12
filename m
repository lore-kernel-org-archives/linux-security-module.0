From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 12 Sep 2017 13:24:54 -0700
Subject: [GIT PULL] SELinux patches for v4.14
In-Reply-To: <CAHC9VhQr8R-=Sgqb7biFkz3G_dAAQG-PRMGe+Lp7SvoHKM=v+w@mail.gmail.com>
References: <CAHC9VhQr8R-=Sgqb7biFkz3G_dAAQG-PRMGe+Lp7SvoHKM=v+w@mail.gmail.com>
Message-ID: <CA+55aFyoctVqwQgOczJ32aOm5xRv0gWyDY9XmUoEBa0XoJ2BJA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 12, 2017 at 10:33 AM, Paul Moore <paul@paul-moore.com> wrote:
> As discussed on the linux-security pull request thread, this is the
> direct SELinux pull request; the content/tag is the same as what I
> sent to James/linux-security earlier:

The contents may be the same, but the base is different.

In particular, you based it on the security tree that already had a
few other patches, so now that branch contains not just selinux work,
but also a couple of tomoyo patches that came in that way.

Anyway, I pulled this simply because it was easier to review and
didn't have anything I disliked per se, but if we're going to actually
keep the different securlty layers separate, they need to also have
clean bases for the work in the future.

Anyway, I'm at the airport on my way back home, and hopefully I'll be
back to normal tomorrow after a good night's sleep, and I can take a
look at the rest.

                Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
