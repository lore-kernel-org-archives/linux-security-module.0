Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082642;
	b=cN8ZqqmfaDkJIh54nhrtyOWg14mS5JEEOuZVapbps8Q4dyGBxJ7Ewq5H3e4EF+m6nlFD
	 S0dJCzgZKTbxx9rEOxOIAD1SZLwdEqtqPQ9lLkAwi7DDhI8o2I3nwRuh6tKoI5VUvyoxQ
	 rJW/D6Du+WvZRoGwdcseYjD/zZIWbzFYj0P83DK837IOp1Q1+YCC20Kyoi3SfiuZEj1v0
	 TZpXPQI3S6FTWim3vKLxpGfvI3qcPPwu49A6qtorUsnog5M+mP2uAXz00hyPP4l6oV1Up
	 AzlUiBFOqd3W0KT2607IeV04nw9H3ZErTwHgzuvf5xy5MzwSMPVI+woWuBbhM16ccOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082642;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=zzyvBYRycK/PolxVws+3x07W7fjNSU/PymweqV0BGzg=;
	b=fR+Y2pqS5ZZlg8i+jRKe6h5FOTh+9nbbk2Iz9GJf+OJy3WEjEi6Du2WAesstPaKe1wyV
	 N2dLxuQ4/1YoY47wmEfVrimHqsze7BDwYV9PZ+je55CIFqgW8QJSvIObnTGUxYS7KBroi
	 +rXo15qwZ1DL46zggPGXs6+7GEwWsOGDeKmx2ksp/qErNmSfEr3Yol/ShZMLUenz/Dlfm
	 1u/nwEMiN4vO1tpwe0scKJa3wQEK9rdedroyGMz24crxK4WeuGxXy9oKwnzWuTpYIPhFf
	 NmlPDnDUJhNOCYNm1Q0d1RHuode2uWqdiCGFcrAmLbz8BjJBna4jz1i/WvshlVr9W+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.154
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8D606A320;
	Thu, 19 Nov 2026 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D8D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jVYvB6jSfzt3HP;
	Thu, 19 Nov 2026 18:03:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id 5BF0640558;
	Thu, 19 Nov 2026 18:03:52 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0BGKV9+yf5qSSEeAA--.14516S2;
	Thu, 19 Nov 2026 11:03:51 +0100 (CET)
Message-ID: <70ebc38f7102d5f75ba1dcbf6df4b4b864c78ce7.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: reject duplicate fsname= in a policy rule
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: weidongw@illinois.edu, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	 <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
	 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zijie Zhao <zijie4@illinois.edu>
Date: Thu, 19 Nov 2026 11:03:39 +0100
In-Reply-To: <20261112-c3-n204-v1-1-dd9400b9ece8@illinois.edu>
References: <20261112-c3-n204-v1-1-dd9400b9ece8@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:nRC2B0BGKV9+yf5qSSEeAA--.14516S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr15ur1fXF4UAr45KF1rWFg_yoW5uFW5pa
	95KFnF9FsrAryIkay293WS9Fyxuw4UJr45GF95J342vasxWrn2vw43KFWY9w12yryrtr1F
	vF4qg3Wqk34qqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIDWr+ac09DQAAsE

On Thu, 2026-11-12 at 00:56 -0600, Weidong Wang via B4 Relay wrote:
> From: Weidong Wang <weidongw@illinois.edu>
>=20
> ima_parse_rule() stores the fsname=3D value with kstrdup() but, unlike
> fsmagic=3D, fs_subtype=3D and the other options, does not check whether t=
he
> rule already has one. A rule that names fsname=3D twice overwrites
> entry->fsname and leaks the first string.
>=20
> Reject the duplicate with -EINVAL, as fs_subtype=3D does. Such a rule use=
d
> to be accepted with the last fsname=3D taking effect; giving the option
> twice was never meaningful, and the other options already reject it.
>=20
> Writing the policy requires CAP_SYS_ADMIN, so the leak is limited to a
> few bytes per malformed rule loaded by a privileged user.
>=20
> The leak was found by an AI code review agent (an LLM-based bug-finding
> tool developed by Zijie Zhao and the submitter) and confirmed on an
> unmodified kernel, without error injection, on x86_64 under QEMU with
> kmemleak: loading 64 rules with a duplicated fsname=3D left 64
> unreferenced objects allocated by kstrdup() in ima_parse_rule() (inlined
> into ima_parse_add_rule()); the same rules with a single fsname=3D left
> none. With this patch the duplicate rules are rejected and kmemleak
> reports nothing; rules with a single fsname=3D are still accepted.
>=20
> The reproducer, fix and changelog were drafted with AI assistance
> (Claude), then reviewed and tested by the submitter.
>=20
> Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the fil=
esystem name")
> Cc: Zijie Zhao <zijie4@illinois.edu>
> Signed-off-by: Weidong Wang <weidongw@illinois.edu>

Thanks.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> ---
> Tested on v7.4-rc1 (05441d697f7f), x86_64, QEMU/KVM, kmemleak, booted
> with slab_debug=3DU. 64 rules written to the IMA policy file at once:
>=20
>   trigger  "dont_measure fsname=3DpocfsA<i> fsname=3DpocfsB<i>"
>   control  "dont_measure fsname=3DpocfsA<i>"
>=20
>                trigger                         control
>   unpatched    accepted; 64 unreferenced       accepted; none
>                objects, all "pocfsA<i>"
>   patched      write rejected; none            accepted; none
>=20
> Without slab_debug=3DU kmemleak reports none of these leaks on this
> kernel: stale pointers in the per-CPU slab sheaves keep the leaked
> strings "referenced". Writing the policy more than once needs
> CONFIG_IMA_WRITE_POLICY=3Dy, which the test kernel has. The code is
> unchanged in mainline, linux-next (next-20261111) and next-integrity.
>=20
> The reproducer is available on request.
> ---
>  security/integrity/ima/ima_policy.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 2dc1d93aa..f08ca00bd 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1619,6 +1619,11 @@ static int ima_parse_rule(char *rule, struct ima_r=
ule_entry *entry)
>  		case Opt_fsname:
>  			ima_log_string(ab, "fsname", args[0].from);
> =20
> +			if (entry->fsname) {
> +				result =3D -EINVAL;
> +				break;
> +			}
> +
>  			entry->fsname =3D kstrdup(args[0].from, GFP_KERNEL);
>  			if (!entry->fsname) {
>  				result =3D -ENOMEM;
>=20
> ---
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> change-id: 20261112-c3-n204-a82e17864b76
>=20
> Best regards,
> -- =20
> Weidong Wang <weidongw@illinois.edu>
>=20
>=20
>=20

