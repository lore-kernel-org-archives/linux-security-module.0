Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB412E339B;
	Tue, 25 Mar 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922089; cv=none; b=G10GeKC6DKTfP7PdaxzVv9zsWI03svSU7TZKBCw+Q96vsNkhJ6/p1MI9ddsCyhIFMvC1rbOxXudpbxYone2Z5OaYnc67OVPLtxK39x6awttLF42ZcmF59Qh1PXCr2/BV3z/04ajM3ck4lB56/XC6CleLPem+EEAwi1ii3TvKpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922089; c=relaxed/simple;
	bh=4hzZb9JEzCVAK6mXROmkBBNUCC+Z2V6igSqYiSTZu80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZ5nxPXOH82y5YsFLdW6TvHTt+3e1KJi2Q8Sc48WszMBQERclST/wKUlEd2ZhJvUq/6jcL5cjaQoiE+BXOL1cBfnbSGJjGytfsfcONwjJ9D6xMKxpz5knSmarGk7cwt/ubYQCfDu7CDkYNfRZeQ+XVLw3IAeVUqqoPJh+13WuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZMblt0KwGz1HBjV;
	Wed, 26 Mar 2025 01:00:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id EBFA51402DA;
	Wed, 26 Mar 2025 01:01:22 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCnXeBZ4eJnCIvSBA--.48204S2;
	Tue, 25 Mar 2025 18:01:22 +0100 (CET)
Message-ID: <c1185901c99091a29a865f7a862bc979873301ad.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: process_measurement() needlessly takes
 inode_lock() on MAY_READ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Frederick Lawler <fred@cloudflare.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric
 Snowberg <eric.snowberg@oracle.com>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-ima-devel@lists.sourceforge.net, 
 linux-ima-user@lists.sourceforge.net,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-team@cloudflare.com
Date: Tue, 25 Mar 2025 18:01:09 +0100
In-Reply-To: <Z-Lc5WxW7NRA6AiT@CMGLRV3>
References: <20250325155934.4120184-1-fred@cloudflare.com>
	 <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>
	 <Z-Lc5WxW7NRA6AiT@CMGLRV3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCnXeBZ4eJnCIvSBA--.48204S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry5uw1rGr1rZryfAFyDtrb_yoW5uFyfp3
	y8Ka1IyF4DKry2kr9rtws0vr4vv3ykGF4UJws5ZF18A3s5Xr1vqr15tayY9FyfXrn5A3Wa
	vF4Ygr43Zan0vFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGfiVd0JSQACsY

On Tue, 2025-03-25 at 11:42 -0500, Frederick Lawler wrote:
> On Tue, Mar 25, 2025 at 05:30:32PM +0100, Roberto Sassu wrote:
> > On 3/25/2025 4:58 PM, Frederick Lawler wrote:
> > > On IMA policy update, if a measure rule exists in the policy,
> > > IMA_MEASURE is set for ima_policy_flags which makes the violation_che=
ck
> > > variable always true. Coupled with a no-action on MAY_READ for a
> > > FILE_CHECK call, we're always taking the inode_lock().
> > >=20
> > > This becomes a performance problem for extremely heavy read-only work=
loads.
> > > Therefore, prevent this only in the case there's no action to be take=
n.
> > >=20
> > > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > > ---
> > >   security/integrity/ima/ima_main.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/i=
ma/ima_main.c
> > > index 2aebb7984437..78921e69ee14 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -181,7 +181,7 @@ static int process_measurement(struct file *file,=
 char *buf, loff_t size,
> > >   	action =3D ima_get_action(inode, mask, func, &pcr);
> > >   	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_C=
HECK) &&
> > >   			   (ima_policy_flag & IMA_MEASURE));
> > > -	if (!action && !violation_check)
> > > +	if (!action && (mask =3D=3D MAY_READ || !violation_check))
> > >   		return 0;
> >=20
>=20
> Hi Roberto,
>=20
> > Hi Frederick
> >=20
> > thanks, nice catch!
> >=20
> > Thinking... in fact you are saying that there are conditions for which
> > ima_rdwr_violation_check() does nothing.
> >=20
> > For better clarity, I would add the conditions for which we are doing a
> > violation check in violation_check directly. So that, one can just go t=
o the
> > function and see that in fact nothing special is done other than doing =
the
> > same checks in advance before taking the lock (the conditions you are
> > checking on are immutable, so it is fine).
> >=20
> > So, it is not a write, and the file is not being measured (this would b=
e a
> > bit redundant given that we are checking anyway !action).
> >=20
> > Thanks
> >=20
>=20
> The ima_rdwr_violation_check() call takes a action & IMA_MEASURE
> argument anyway.
>=20
> My initial thought was to replace ima_flag_policy & IMA_MEASURE with
> action & IMA_MEASURE there, but I wasn't sure if there was a race
> problem that the ima_rdwr_violation_check() is trying to catch for the no=
n
> FILE_CHECK cases.

Let's keep as it is for now.

> Otherwise, I think the checks in the ima_rdwr_violation_check() demand th=
e lock,
> and therefore we can't just move them out to that violation_check
> variable--unless I'm missing something. As for other conditions, I think
> it's _just_ the MAY_READ we care about.

Yes, of course.

I meant, since in ima_rdwr_violation_check() there is:


if (mode & FMODE_WRITE)
...
else if (... && must_measure)


which don't need to be under lock, then I would have modified
violation_check to:

	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK ||
			    func =3D=3D MMAP_CHECK_REQPROT) &&
			   (ima_policy_flag & IMA_MEASURE)) &&
			   ((action & IMA_MEASURE) || (mask & MAY_WRITE));

Roberto

> Is what you're suggesting to move the check mask =3D=3D MAY_READ to inste=
ad be in
> that violation_check variable than the branch?
>=20
> > Roberto
> >=20
> > >   	must_appraise =3D action & IMA_APPRAISE;
> >=20
>=20
> Thanks,
> Fred

