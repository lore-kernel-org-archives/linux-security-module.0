From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Tue, 13 Jun 2017 09:51:24 +0200
Subject: [PATCH 03/11] Creation of "usb_device_auth" LSM hook
In-Reply-To: <8219df49-321d-d032-48b5-cf1cd5a46664@schaufler-ca.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-4-git-send-email-s.mesoraca16@gmail.com>
	<8219df49-321d-d032-48b5-cf1cd5a46664@schaufler-ca.com>
Message-ID: <CAJHCu1+5x47b8Dz6F7DdoX7dDGKOT8g-LGYmGb3GV_4CTqBjLA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-12 23:31 GMT+02:00 Casey Schaufler <casey@schaufler-ca.com>:
> Return the error reported by the hook rather than -EPERM.

Agreed, anyway this part will be, probably, dropped in
the next version (read Greg and Krzysztof answers).
I'm sorry :(

Thank you very much for the time you spent on this.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
