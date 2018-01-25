From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Jan 2018 22:02:49 +0100
Subject: [PATCH v2 01/15] Documentation: add newcx initramfs format
	description
In-Reply-To: <151691200536.5378.11544479301138437367@takondra-t460s>
References: <1516850875-25066-1-git-send-email-takondra@cisco.com>
	<1516850875-25066-2-git-send-email-takondra@cisco.com>
	<CAK8P3a2FqEcq44-sRQrsgJ=_DOanC-qgJ3yFr=J6UrOKO0_3uw@mail.gmail.com>
	<151691200536.5378.11544479301138437367@takondra-t460s>
Message-ID: <CAK8P3a06d66eEwxGtezGhfqxYLg9hPiTm5aXRzC=rMwoWQ=dpA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jan 25, 2018 at 9:26 PM, Taras Kondratiuk <takondra@cisco.com> wrote:
> Quoting Arnd Bergmann (2018-01-25 01:29:12)
>> On Thu, Jan 25, 2018 at 4:27 AM, Taras Kondratiuk <takondra@cisco.com> wrote:
>
> We can match statx(2) by having 64 bits for seconds plus 32 bits for
> nanoseconds.

Ok.

> For initramfs nanoseconds field can be ignored during
> unpacking.

That sounds like a pointless microoptimization. Most likely we won't ever
need the nanoseconds in the initramfs, but it's trivial to just copy them
into the right field, and not adding that one source line would probably
involve adding a one-line source comment to explain the omission ;-)

      Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
