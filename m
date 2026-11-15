Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751191;
	b=LvCr21HYL5syNnn4I7ngGLPdDOP2C30rrPfYzHW6kOzCkK+ARNKdh3zc3+V/9/JrjZPj
	 JJjf/Kwsnxz0HSH+miSmRhhmNn5HFuHm4+AgtgdouOYzKzQtUkSzltEjRcqsoNu+xWwQY
	 RJ06WyLk+OpBMPREKIJ0bZ/779IovRNkgF2ymItzJYla0QiWS52ikus5zp6SUvFUwuo9a
	 Xp2Bcivmcygo8aMSJO5XB/qrp1clPaOq9M8csMjJYvv7LKkE6Xuh83xx35L8/tcGDRD4u
	 nxSvu3eJpS3F2lwdwXnnWoNcpYWbiwwVAbldVe6jCyeaZFuI5uhOO1zflnd6VFGsoSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751191;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EeqP4pkKpTrcPcDp8zrtcPNrjaDgaSyW6ZXH4x5jWOM=;
	b=UyOxqloplBhLSiZQyFYZIICYdMRy4Ykh+oqJvOrmVaIc/cH0crSeDOetkOjVtW0/ZLJW
	 dCCcH+xwMKDDxn99MoEATphjIL4iyrYNl/TSfvMnqY20AJjXys49mJ3QrHn/EdGXpPJiD
	 CjPTRE0Hrgt7MQIlNfrk+HbpO1rBQ/U50J8iznTnelWhjDIiOsQjhfxg3ultFNuuSumqx
	 FDtgHzqY+WqKLNEmp8ib4bBOydXeO0PQhk31p+StZjVlYd95zXYro+OgV1hEbKJGoB0/1
	 th/i9VX89X+YDehrpOv9r5YoIjkNIPZbM+bfYRo87t1MQvxVXs4Jci5Av7m5EwK3K5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=F63NPrnY;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945A606A31A;
	Sun, 15 Nov 2026 13:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1945A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=F63NPrnY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794751178; bh=EeqP4pkKpTrcPcDp8zrtcPNrjaDgaSyW6ZXH4x5jWOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F63NPrnYbWi8xCmT6ViM0TKlfZ8psgx5zuYb7GrH2IHdrzBfJ1z6I2KxXipb0x9gR
	 AyGV2/sO4SQflV3Hqolm3ChE1C/izhzqhHTo0PlytNSNvE9pgpJUfnuFQKOdsmSKvO
	 OhKM8rUoa6PPgWnpHfCk85M4pbgl+CP//r5F2aDI=
Received: from [192.168.1.9] ([163.125.232.4])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id EE397A48; Sun, 15 Nov 2026 21:59:35 +0800
X-QQ-mid: xmsmtpt1794751175tjyn5xa78
Message-ID: <tencent_EAF72EE1486DCC13E1E47DCFA5CF52290B05@qq.com>
X-QQ-XMAILINFO: MEDFSjkiIE+fCraagdh9Vk5QeSOL0QSr8z2d/+rq/O2kZnUdvbkH0qyOk8U4cL
	 /oq5Ia8PwyMFpKK01BdEScMNVumu8TRcBF6cmlPghKBQ8Lnn7l0MoJsOOVKoAJ7jHFJYaEcRBfcr
	 HNqtMwrbeXUjNhIkNpNBNFX4cEHjsng9TFHX+9yFW/aN0jKdEgs2urZ+d0Lki4I9ZN3iqoRJJvzd
	 gaBk38PKkPVE9PrNfVFWP6ICWR2xmMYOtl1pLmDJ4GGsScYn/ubm9QawsQT8sbWK4qDiRZ2z3QV/
	 GObyUwgwosk1elep023cUn05YaG1ozml3Vjujg4oWR5oQFKuc3+fMKhB56rI1K4vgBJhCP6OGY2u
	 MpvuQ4bgZjFn/oALfjtY24uVUGrZUaMFdIoRzcUy39VrjIuOlGk8n68FioEqoNW/K/JhivF0FHAb
	 bdHmAYthaDs+X+gieBMdAKEqEfjbYP+Ncbuipin+DwBLkckNrZMBsSiAZvV/Dm4q9K10PALIuGS+
	 9mCyzGXGlprVNJI4NacisVVic6Amoeh16Ug4eSbZTHsauBDcG2WK3QKEF+dZYF2da57uiOHIETin
	 vPRhQFJkYwXrXRipiyE/j/IrypLa+mek9gX4yHh8N3OY1oOcRtWtUlkPcr04I1BhYRj9MAODZAhG
	 U4MCTlnWG5KdQT+HQhF5BjGAkxBhCnYk9z2pb6uD54ycem4vpHvMjY9arZpOVBx6udaizvYC5FUh
	 PhL2GAzwlPcFRisWVg6yLfIctD7gtlrnPygDv1CDp2JfV4rYHYuZ1M3qEtSYGdTCFhV/P3+gXRLk
	 hVqvxrwu6Xmxvx3SjBejcWBVCemKlb6djw5i+ENhhGsMyFPq07YQv6Elal2Q4YTxoH/Ny9va0tX+
	 vMLhR9yBM3sbCdZjzb8PlKA+ifvSYDj7xXnm8saVPBN8Kzf8qkDYu64Dkted2WWf8U6nX6d1kjuD
	 dQL7utGIgotpzoZ3GFYbWMoyVVwVmrMsh1cd28+2w6EGcGJ+PctEzyNYsTiGRQfWwOulRBRyDWD9
	 iotP1Zy+swSb6BORUyvlt2JiQhjJBxO68WP44U2/mkmkFyposYsSk9g/zjpwJSMHSinlTIL/cOQb
	 pHujZIHIxaUoZH/ET6oMEloDj97Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <f4c4e7c3-7327-4779-a33f-7f4027c5c26e@qq.com>
Date: Sun, 15 Nov 2026 22:03:43 +0800
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
To: Weijie Yuan <wy@wyuan.org>
Cc: dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
 linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net, mic@digikod.net
References: <tencent_001080DF135CEE2CD1B260EFA08E3CC71A09@qq.com>
 <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>
 <aunHXtl-L__1isgc@wyuan.org>
From: Yan Zhu <zhuyan2015@qq.com>
In-Reply-To: <aunHXtl-L__1isgc@wyuan.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2026 7:37 PM, Weijie Yuan wrote:
> Yan Zhu <zhuyan2015@qq.com> writes:
> 
>> Ping
>>
>> On 6/12/2026 11:58 PM, Yan Zhu wrote:
>>> This patch series adds the Chinese translation for the Linux Security Module
>>> (LSM) admin-guide documentation, including the main index and all ten
>>> sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
>>> ipe, and landlock.  The admin-guide toctree is also updated to list the
>>> newly translated LSM/index.
>>>
>>> The original English documentation was restructured into reStructuredText
>>> by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
>>> and each sub-page has been kept up-to-date with subsequent mainline changes.
>>>
>>>
>>> base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next
>>>
>>>
>>>
>>> Yan Zhu (10):
>>>     docs/zh_CN: add LSM/index Chinese translation
>>>     docs/zh_CN: add LSM/apparmor Chinese translation
>>>     docs/zh_CN: add LSM/LoadPin Chinese translation
>>>     docs/zh_CN: add LSM/SELinux Chinese translation
>>>     docs/zh_CN: add LSM/Smack Chinese translation
>>>     docs/zh_CN: add LSM/tomoyo Chinese translation
>>>     docs/zh_CN: add LSM/Yama Chinese translation
>>>     docs/zh_CN: add LSM/SafeSetID Chinese translation
>>>     docs/zh_CN: add LSM/ipe Chinese translation
>>>     docs/zh_CN: add LSM/landlock Chinese translation
> 
> Hi,
> 
> I suspect that your series was long since buried in maintainers' inbox,
> because your actual patches are not "In-Reply-To" this cover letter.
> 
> And I do remember I mentioned it elsewhere that it may has something to
> do with your QQ email server.  I suggest resending this serie after
> fixing email stuffs.

Thanks for your suggestion. I will resend these patches.

-- 
Thanks
Yan Zhu

