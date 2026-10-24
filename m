Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854230;
	b=zwTRYG32nRBXi+Pr66O9QPqypjsv9TZDWPBaPGzW2Aa18ylvQbhQV8o/gHY1pNtnGkyI
	 CD0MRXCp1uhx1dcX2ab6qbOSVVuxPIZUIzlSAPa9yFPo7I2LWXLzWoahUyW2hWsavVMGL
	 JiFkjSvZnTdBI8lrN//pD9DoMCX6l716gdarnDP4EbtdsDH/P/qV15E60tY+YQw1lQTeU
	 DrFuQlq6Dry5Dug5m3Rxq4tJM1LTLc7sK6tenWwJ/sMTpOgWowd2MI/S2V1MYY9WhnkXO
	 9lfXxzpwzy4/DW5QWVzqa7f3jQ9LQP5fN9Tje6AsrotuAQ2FaDUPkEVa4LARyzY0YqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854230;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xk9airSWM+YEyVXP8MNP1OJgA0vrH2iz/FkgQwAQ6qE=;
	b=4fLgiCuBNXaSS+UmDRXkpJO/nPayBSTXMwJI6h5RK8yA53wQT912kpDvu+AptyPWU8jI
	 OGwni1to4wQN3LRxQ9aQ+6wOPw1/gRvjoA6V5fY4TwnQVKs46RDavg8x4IZ6qdVtIznda
	 cWFIEnPZ9LQEbkC2fdo8vf9VtfOMez+nLvf6D5HDGMYipq0yv6ofrZriW0fyMg6oRISC0
	 p2K1xm6fSF2r7IzA/3cJ1qp+e8IqI0LWfxpSPZPjuC5Nzolg72zeSkB5wnsrZefhOFhCM
	 ld0nAGWUVgp4foc/oJgkcHemgm4AN3+8UeSCI+1Enk7ruBIKBvwfp/4kHW9pvqccTRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fqenK3xx;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB3606A31E;
	Sat, 24 Oct 2026 15:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65FB3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fqenK3xx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792854223; bh=xk9airSWM+YEyVXP8MNP1OJgA0vrH2iz/FkgQwAQ6qE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fqenK3xxW/DxVzJvVMAbKxpRVLAsL4KU/0YPWGQVZ3mpfX7Blf5fVTWYj8luSccRa
	 RdkA4jPrHC1+oqM1ZrDfek/SOfyJxCyRLDw67NqWAlwIaRmnux9E0B2S2SJuxc+xYw
	 gwtkXPEk3dazxUr4/sYeHpW1kyJj+ss/xMs2gITo=
Received: from [192.168.1.9] ([163.125.219.209])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id E88A017; Sat, 24 Oct 2026 23:03:40 +0800
X-QQ-mid: xmsmtpt1792854220tgi7wo48f
Message-ID: <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>
X-QQ-XMAILINFO: N6IfSeM/PG+tBeimLU8RM+bXo26YOiITtRSkyB/D5VVVyRqCiKcT7NyI6qSsg6
	 Lhnrpui0+7TScq/R7AFJj/z1JwJHXbuA/E6tSpagC14fa2LqfiVGqQtIQatkjM4bUX8YTWy+azLA
	 uO8bb8EmpvaHJTk7rrXVI8kfyhA0bjwFvvwesQCKmxtUtOEtmvN0dau2Sg+vb/pRErbP+fMzlfaC
	 hq5PO+40Wbms0xSMpwIeoBPdqHYEspgF+XGKJetCl76ODiH/ee+oNbIT4ZEWneq25QrLCAlL0J7B
	 uAVzwzPPxLoxC1rvKhF2NfkjsuCw4GAcisN1cDErTPjKKSiIdbKSh0fnpETJPGY9QwcbP8oid17c
	 3lIGN5OsTW9KTDLQ7fezl+hT1PQXAKOJaKyOqBPsf9A+Ot2F88huW2NOOxQB3F5MgqFVEDwKLLmx
	 p29tv8xhqlKUAHQNBLU+ApDFnOh9v9mh010jzFq3kL6kZr9BhGr1CtnlnjyhM38/O7306FqAJwCc
	 9rdelYUvzuh02GBjnkglqyJMh89oNMSgvro6NWBU02B05SkRWIydoRcnJxTjLRY4V3N5JkuLkx43
	 RyVKxVsA8T1vxO+M6x+pPaGFOvxr+7DaIAcpwRCjvydi8bDf/qxrN30L0n1LdWGURD+h30otTqBS
	 PKkflHc4hnjCtx5lueQOzQf975jymoQTkppDg5G3MMDSm7CeF0wrJ0iedfCSb24NjemeeY9W0CUn
	 bLXUc9nTxa2Bx1jqJoKzm7O9V0TF6N7t/QC0fVWz3l7CNiw8mZpzyxo7rACZj6x8ajp/8pWIKlXl
	 2JF+8I/sX+mkZkS+5NfXw+VICjIsU5+QWULhokS7EX7FtH2S3g9jJIkZbkFIH/mbvy7kciOMwqUd
	 qp/nyNuK8J2GOjcGQ6KsBx8EoqZKA8rh4cvBXpzPEfDTuU+5W1v6oVpIDRlUZbWMY6X06X6lPhFx
	 HrRHjUEyoAjv1aKVDy5fpQ0TJ/sgkjq0G5FiYU0XEsCyt6CX7+zFGc5i3K4qLobZjSDoppvPIFMq
	 Q5710+nT7DLH/BDSSgAn1p5Vm5T7BUGZD1irjgcw0RMxWSJvgVwUTxN/YDt+CcFl0Ye51aCeZFZf
	 zcIfc7pt9OAC6IFilfahtctDPFX0ZiwjdR+6FA9hJektU4gLmeMJpnBP9izA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-OQ-MSGID: <b3a2a829-c0d7-4ed2-9409-7086fb65909f@qq.com>
Date: Sat, 24 Oct 2026 23:07:11 +0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
To: zhuyan2015@qq.com
Cc: dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net
References: <tencent_001080DF135CEE2CD1B260EFA08E3CC71A09@qq.com>
From: Yan Zhu <zhuyan2015@qq.com>
In-Reply-To: <tencent_001080DF135CEE2CD1B260EFA08E3CC71A09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ping

On 6/12/2026 11:58 PM, Yan Zhu wrote:
> This patch series adds the Chinese translation for the Linux Security Module
> (LSM) admin-guide documentation, including the main index and all ten
> sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
> ipe, and landlock.  The admin-guide toctree is also updated to list the
> newly translated LSM/index.
> 
> The original English documentation was restructured into reStructuredText
> by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
> and each sub-page has been kept up-to-date with subsequent mainline changes.
> 
> 
> base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next
> 
> 
> 
> Yan Zhu (10):
>    docs/zh_CN: add LSM/index Chinese translation
>    docs/zh_CN: add LSM/apparmor Chinese translation
>    docs/zh_CN: add LSM/LoadPin Chinese translation
>    docs/zh_CN: add LSM/SELinux Chinese translation
>    docs/zh_CN: add LSM/Smack Chinese translation
>    docs/zh_CN: add LSM/tomoyo Chinese translation
>    docs/zh_CN: add LSM/Yama Chinese translation
>    docs/zh_CN: add LSM/SafeSetID Chinese translation
>    docs/zh_CN: add LSM/ipe Chinese translation
>    docs/zh_CN: add LSM/landlock Chinese translation
> 
>   .../zh_CN/admin-guide/LSM/LoadPin.rst         |  33 +
>   .../zh_CN/admin-guide/LSM/SELinux.rst         |  45 ++
>   .../zh_CN/admin-guide/LSM/SafeSetID.rst       |  82 ++
>   .../zh_CN/admin-guide/LSM/Smack.rst           | 722 +++++++++++++++++
>   .../zh_CN/admin-guide/LSM/Yama.rst            |  71 ++
>   .../zh_CN/admin-guide/LSM/apparmor.rst        |  59 ++
>   .../zh_CN/admin-guide/LSM/index.rst           |  46 ++
>   .../zh_CN/admin-guide/LSM/ipe.rst             | 723 ++++++++++++++++++
>   .../zh_CN/admin-guide/LSM/landlock.rst        | 169 ++++
>   .../zh_CN/admin-guide/LSM/tomoyo.rst          |  63 ++
>   .../translations/zh_CN/admin-guide/index.rst  |   3 +-
>   11 files changed, 2015 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/LoadPin.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SELinux.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/SafeSetID.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Smack.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/Yama.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/apparmor.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/index.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/ipe.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/landlock.rst
>   create mode 100644 Documentation/translations/zh_CN/admin-guide/LSM/tomoyo.rst
> 

-- 
Thanks
Yan Zhu

