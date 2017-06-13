From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 13 Jun 2017 09:47:33 +0200
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <75f33a0f-4643-fe17-fc35-b60b48efd499@samsung.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<CGME20170612170045epcas2p2889350eed8fb2caaa592ef8e6e2c12bf@epcas2p2.samsung.com>
	<1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
	<75f33a0f-4643-fe17-fc35-b60b48efd499@samsung.com>
Message-ID: <CAJHCu1KORP9vKTSRCVNUBP3dfgiL6yg3DDEpuBjPc4r-iA3DEg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-12 19:35 GMT+02:00 Krzysztof Opasiak <k.opasiak@samsung.com>:
> Could you please explain me why we need LSM for this?
>
> There are tools like usbguard[1] and as far as I can tell it looks like they
> can do everything for you...

I have to admit that this is the first time I read about usbguard and it made
me realize that this feature can be implemented in userspace, so no need
to modify the kernel. :)
You are right.

Thank you very much for taking the time to answer me.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
