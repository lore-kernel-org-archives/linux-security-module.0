From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 31 Jan 2018 13:21:44 -0800
Subject: [GIT PULL] Security subsystem updates for v4.16
In-Reply-To: <alpine.LRH.2.21.1801291040280.29680@namei.org>
References: <alpine.LRH.2.21.1801291040280.29680@namei.org>
Message-ID: <CA+55aFw1vWWmv5Ebq9yWVDFm4SQUG_fNd3f5yoYkWRTfUNaL_Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 28, 2018 at 3:41 PM, James Morris <jmorris@namei.org> wrote:
>
> Note that individual trees may also be pulled via:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>         next-integrity
>         next-smack
>         next-tpm

So I did that, because it makes it easier and more controlled for me.
But then when double-checking that the end result is identical to your
full pull request, I end up missing the seccomp tree.

I can pull that separately too, but it was missing explanations and a
real pull request, so I left it alone.

           Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
