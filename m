From: k.opasiak@samsung.com (Krzysztof Opasiak)
Date: Mon, 12 Jun 2017 19:35:06 +0200
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<CGME20170612170045epcas2p2889350eed8fb2caaa592ef8e6e2c12bf@epcas2p2.samsung.com>
	<1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <75f33a0f-4643-fe17-fc35-b60b48efd499@samsung.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

On 06/12/2017 06:56 PM, Salvatore Mesoraca wrote:
> Creation of a new LSM hook that can be used to authorize or deauthorize
> new USB devices via the usb authorization interface.
> The same hook can also prevent the authorization of a USB device via
> "/sys/bus/usb/devices/DEVICE/authorized".
> Using this hook an LSM could provide an higher level of granularity
> than the current authorization interface.
>

Could you please explain me why we need LSM for this?

There are tools like usbguard[1] and as far as I can tell it looks like 
they can do everything for you...
Without kernel modification...
without matching and storing rules inside kernel..
just pure userspace which uses device/interface authorization

Footnote:
1 - https://dkopecek.github.io/usbguard/

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
