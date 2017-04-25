From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 25 Apr 2017 14:47:46 +0100
Subject: [PATCH v5 0/2] security: tty: make TIOCSTI ioctl require
	CAP_SYS_ADMIN
In-Reply-To: <20170425041512.13189-1-matt@nmatt.com>
References: <20170425041512.13189-1-matt@nmatt.com>
Message-ID: <20170425144746.0d8721a3@lxorguk.ukuu.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> There could be a few user programs that would be effected by this
> change.
> See: <https://codesearch.debian.net/search?q=ioctl%5C%28.*TIOCSTI>
> notable programs are: agetty, csh, xemacs and tcsh
> 
> However, I still believe that this change is worth it given that the
> Kconfig defaults to n. This will be a feature that is turned on for the
> same reason that people activate it when using grsecurity. Users of this
> opt-in feature will realize that they are choosing security over some OS
> features 

Only in this case they are not.

If I am at the point I have the ability to send you TIOCSTI you already
lost because I can just open /dev/tty to get access to my controlling tty
and use write().

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
