From: takondra@cisco.com (Taras Kondratiuk)
Date: Thu, 25 Jan 2018 14:13:56 -0800
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
	<151691200536.5378.11544479301138437367@takondra-t460s>
	<CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
Message-ID: <151691843634.9300.9473350782231091007@takondra-t460s>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Arnd Bergmann (2018-01-25 13:02:49)
> On Thu, Jan 25, 2018 at 9:26 PM, Taras Kondratiuk <takondra@cisco.com> wrote:
> 
> > For initramfs nanoseconds field can be ignored during
> > unpacking.
> 
> That sounds like a pointless microoptimization. Most likely we won't ever
> need the nanoseconds in the initramfs, but it's trivial to just copy them
> into the right field, and not adding that one source line would probably
> involve adding a one-line source comment to explain the omission ;-)

Agree.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
