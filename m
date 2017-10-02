From: dhowells@redhat.com (David Howells)
Date: Mon, 02 Oct 2017 22:12:04 +0100
Subject: Modular BIG_KEYS (was: Re: [PATCH v4] security/keys: rewrite all
	of big_key crypto)
In-Reply-To: <CAMuHMdWd3ttH7Zdpo=bodkOBw2xiyeX_R9MhPf=Bcf0-QLhOiQ@mail.gmail.com>
References: <CAMuHMdWd3ttH7Zdpo=bodkOBw2xiyeX_R9MhPf=Bcf0-QLhOiQ@mail.gmail.com>
Message-ID: <7444.1506978724@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Now this has hit mainline, the "BIG_KEYS" Kconfig symbol appeared on my
> radar. Is there any reason this cannot be tristate?

It was tristate, but it got converted to bool:

	commit 2eaf6b5dcafda2b8c22930eff7f48a364fce1741
	KEYS: Make BIG_KEYS boolean

and then:

	commit a1f2bdf338f15dbad10ee6362891ebf79244858b
	security/keys: make big_key.c explicitly non-modular

> So to save kernel size, I wan't to save N, but for a distro kernel that might
> have Kerberos users, you currently need to say Y, while M would be nicer.

If you want to do that, you'll need to implement demand-loading of key type
modules.

Note that you'd end up using a minimum of a whole page as a module rather than
~2K if built in (I know, that's a compromise you have to decide on).

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
