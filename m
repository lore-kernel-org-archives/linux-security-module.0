From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Mon, 10 Jul 2017 09:59:03 +0200
Subject: [kernel-hardening] [PATCH 00/11] S.A.R.A. a new stacked LSM
In-Reply-To: <53a2d710-b0f0-cdf9-e7ad-cd8d03fc835a@digikod.net>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<53a2d710-b0f0-cdf9-e7ad-cd8d03fc835a@digikod.net>
Message-ID: <CAJHCu1+=uYQ-N7CH4KfmTHrN2hJjwzN0tgg4sWHU0LjVr+uGGA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-07-09 21:35 GMT+02:00 Micka?l Sala?n <mic@digikod.net>:
> Hi,
>
> I think it make sense to merge the W^X features with the TPE/shebang LSM
> [1].
>
> Regards,
>  Micka?l
>
> [1]
> https://lkml.kernel.org/r/d9aca46b-97c6-4faf-b559-484feb4aa640 at digikod.net

Hi,
Can you elaborate why it would be an advantage to have those features merged?
They seem quite unrelated.
Also, they work in rather different ways in respect to how they are configured.
I'm not sure what would be a reasonable way to merge them.
Thank you for your comment,

Salvatore
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
