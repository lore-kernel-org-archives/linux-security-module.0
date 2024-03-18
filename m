Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F842119
	for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758400; cv=none; b=HQ7Qfh62YU3DGse11ZQJCLeYbmiDMKx+mzO7AiFu3dYoJSDPYlw9aw4o/Oh4S7y6LuiBzJJTLixoa7yrQYpOvWkTB2hS0tH1fZTwH9SMdWOXzCIrfC+sOb8YOktblaEcBONaSvw1vI9C7Y7LQMGJNhhCtEgpz7p4OhL6FLDvId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758400; c=relaxed/simple;
	bh=qwJg2SFzhv2HrJ+K8kZ+OazojgloNpZJQBPBxco5V4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkVB/ZjlOk19cfF/x5PG4ATEJSTcn6BQ4tS0Ubrxd1pT94B3WI1ptLNw9cdirQ1clbtkQ1tDouqazGZsQzYT1eHuGEQcwAJcjPZqmRqjRAUloPBWvlaOWNCMtRMapPgV5SmQi6t7T3O790W5Bm0/FDI9Nee0jZ6rcpJx38Ggi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TyrSj2R69z9v7HK
	for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 18:19:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 66F9614040F
	for <linux-security-module@vger.kernel.org>; Mon, 18 Mar 2024 18:39:48 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDn3hfuGfhlIkeMBA--.54457S2;
	Mon, 18 Mar 2024 11:39:47 +0100 (CET)
Message-ID: <3ae1387eda0da59199e3e7f736d8dd30281b6b9d.camel@huaweicloud.com>
Subject: Re: LSM/IMA integration denying access to inode_init_security.
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Dr. Greg" <greg@enjellic.com>, paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org
Date: Mon, 18 Mar 2024 11:39:38 +0100
In-Reply-To: <20240318093825.GA30817@wind.enjellic.com>
References: <20240318093825.GA30817@wind.enjellic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDn3hfuGfhlIkeMBA--.54457S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15GFW7AFWrCF43XF45GFg_yoW8Kw4rpF
	Wag3WFkr1Dta12gry0yr17Wa409rWrGr4UWFWktr1jyan8Kr1SqryI9w4Y9FW8Gr48Zw1j
	q3Z0yrnxuas8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5uAQwAAsq

On Mon, 2024-03-18 at 04:38 -0500, Dr. Greg wrote:
> Good morning Paul/Roberto, I hope this note finds your respective
> weeks starting well, greetings to the wider security list as well.
>=20
> We ran into an issue, that seems to be secondary to the LSM/IMA
> integration, in our TSEM port to the 6.8 kernel that would seem to be
> relevant to other or future LSM's.
>=20
> It appears that the IMA/LSM work added the following code to the
> security/security.c:security_inode_init_security() function:
>=20
> if (!blob_sizes.lbs_xattr_count)
> 	return 0;
>=20
> Which denies access to the hook by an LSM that has registered a
> handler for an event but that has not registered the use of extended
> attributes through the LSM blob mechanism.  This pre-supposes the
> notion that all LSM's that may want to be notified of an inode
> instantiation event will be using extended attributes.
>=20
> For example, in TSEM we use this hook to propagate task identity
> ownership and inode instance information from the
> security_inode_create hook into the TSEM inode security state
> information.
>=20
> We 'fixed' the problem by requesting a single extended attribute
> allocation for TSEM, but that seems inelegant in the larger picture,
> given that a handler that wishes to use the hook in the absence of
> extended attributes can use the hook and return EOPNOTSUPP with no ill
> effects.

Hi Greg

I agree, it should not be needed.

> We haven't had time to track down the involved code but a cursory
> examination would seem to suggest that this also effectively denies
> the ability to create an operational BPF hook for this handler.  Given
> that BPF is proposed as a mechanism to implement just any arbitrary
> security policy, this would seem problematic, if it doesn't already
> break current BPF LSM implementations that may have placed a handler
> on this event.
>=20
> We could certainly roll a patch for consideration on how to address
> this issue if that would be of assistance.  At the very least the
> documentation for the function no longer matches its operational
> characteristics.

I think the check above was just an optimization, but I agree you might
do other tasks, other than just filling the xattrs slot.

For me, it would not be really a problem to modify the code to invoke
the inode_init_security hooks with xattrs set to NULL.

I haven't found any counterargument, but will think some more.

> Have a good week.

You too!

Roberto

