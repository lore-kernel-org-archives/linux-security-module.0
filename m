Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7941B948
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172448; cv=none; b=HnAVtezH5M8Cpaqxn9Of6m7/liIlFnFeMJ3dTW92c7++Fr2MDDPGICFOIQnE8Cf3C3FG4FFcPMZEKJSEgHTL7jEpY93SarOiYg/hZe/vSSuv9whjI52bYS5Y3vIuxLJOO/PvcK8BpWOhourt8QBd9moE4SYax0wXIiF1QQ7WK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172448; c=relaxed/simple;
	bh=97fmu8uM4Ty1rc2l8b3DVOy35gTo7K25GpxTW3YyFUs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ac/tREBIPPv7OtK7pVOG4fLGHZBfVFweAVbSB1n9EM5XNs+G9VA4wBaTrq/IMrGl371md9mjTvyZfs2OcrIxF+2PWW4Z90Vqp2/mjo7tN9O8qAfqSYDjb7dWlHVLCizQr8UzZ9+vCxxGvuhae2PVByBDu3V0rAjxeMgp2Oe3/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TLDW663WDz9xtV9
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 16:28:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DB9611404DB
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 16:47:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCnURoWILJlWlM4AQ--.34858S2;
	Thu, 25 Jan 2024 09:47:22 +0100 (CET)
Message-ID: <41a855ac576119ec9cb614cfaeb68c0fe8c5ffc0.camel@huaweicloud.com>
Subject: Re: security_file_free contract/expectations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Ben Smith
	 <ben.smith@crowdstrike.com>, "linux-security-module@vger.kernel.org"
	 <linux-security-module@vger.kernel.org>
Date: Thu, 25 Jan 2024 09:47:16 +0100
In-Reply-To: <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
	 <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCnURoWILJlWlM4AQ--.34858S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DXF17Xr15AFW3Kr1fCrg_yoW8Xw1fpF
	WFka1UGr1DtF18GrnFyanrGFyYkrW3KF1YgF9Yvw45Cr15Wr9avr4SkFy5uFWUKFs5Aw10
	qrZFgr9rCas8AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBF1jj5jsCwABsH

On Wed, 2024-01-24 at 17:14 -0800, Casey Schaufler wrote:
> On 1/24/2024 3:46 PM, Ben Smith wrote:
> > Hi, I'm looking at a kernel panic and I'm trying to figure out whether =
the code in question is doing something that breaks the contract for the se=
curity_file_free hook. I'm specifically wondering whether it's expected/saf=
e for code called from security_file_free to open and read from a file. In =
the case I'm looking at what happens is:
>=20
> The only action that should take place in a _file_free() hook is to manag=
e
> resources used by the LSM. That could involve a kfree() of the module's
> blob, or some other memory management operation.  Trying to access a file
> from this hook is a bad idea.

I'm introducing a new LSM called file_release, that can be suitable for
reading the file (actually IMA will use this functionality).

https://lore.kernel.org/linux-integrity/20240115181809.885385-14-roberto.sa=
ssu@huaweicloud.com/

Roberto

> >=20
> > - Process exit
> > - exit_fs() sets current->fs to NULL
> > - exit_task_work() calls __fput() on files which were closed in exit_fi=
les()
> > - __fput() calls security_file_free()
> > - security_file_free() then reads the file that was just closed in orde=
r to gather information about it.
> > - a filesystem driver (I've seen this with two out-of-tree filesystems)=
 then accesses current->fs and panics.
> >=20
> > So I'm wondering if the expectation here is that filesystem code should=
 NULL check current->fs before using it or that an LSM shouldn't try to rea=
d a file from security_file_free().
> >=20
> >=20

