Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517108;
	b=ty9KEC6BJTFf94wnDpJo+3CO0GpaCqHeFERN/CPbjZluWQ5vbRBQGFEEU1e2efHBwUjH
	 W2/hf0YaIrtn5lOMgKPVP+Dx9nKfisl3Jvw3CrkxSwfyZoJBdwBeDgAdYk5inNIcsZi5A
	 7AcIdrHfUUZGGfk7tz9YQAZPmDhpP9rj3I2dIcGtuptR+7c0Q7bf2tG74ZguO/Jvrs0dS
	 WdIRteRxJ8J0XhAmDcY373bN4Gz09pyQsPJQYkUqwS07iZ019tdCU252IBKgUJ6Fi7zJf
	 B2fj2vZsb0dWCUn1SQ2DeNLm3f3p4IrFevQAGB47kg+RKuyHvGAKx6DcoRuV/bZQ5Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517108;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Subject:From:To:
	 Cc:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=oHmApt22sGJgIykqbV1XXU900yksxIC1U+2k6Mekqaw=;
	b=A4nN8VttnT+tq1HjU7S1xLqra3azTmOVRkwGl3MaK/3PB+R9Cu3VkFaxM8awHivT4xRS
	 aBW6bk5cET+XG/N6U3Y4Kl9rfabXn0nNuUlJRSH7zJQ5M4Lx7tS2hrTaiYt+6ZkoBpZTc
	 3bZ+DAwI/0SETIBe+/ViDDJ3h4sZzoGiWTeT8u5NN4j/ZqBtA7io1Ak0hMATknIWxR/Vq
	 hCD+/w/YwUjbkSEDj+skaLBq4XbkSOWl9wPGzr9sFRnUYnw1RY7OmuRkncamCu3Co7bG/
	 P+ZSf/tBcx3SFRneLdv97I2PbhyRLCYFlUQ1pMz/2yIenmIww66Fg9YzPFq64dijcQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=14.137.139.154
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE62606A32D;
	Tue, 24 Nov 2026 10:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE62606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jYfZ91JtXzt8TV;
	Tue, 24 Nov 2026 18:44:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.157])
	by mail.maildlp.com (Postfix) with ESMTP id A7B7F4055F;
	Tue, 24 Nov 2026 18:44:56 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by dep2_app1 (Coremail) with UTF8SMTPA id nRC2B0CWdlyfagVrZOAoAA--.19598S2;
	Tue, 24 Nov 2026 11:44:56 +0100 (CET)
Message-ID: <c94fe761a15fd88a1be7b81b1c183a87348664fc.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Fix out-of-bounds read in ima_read_policy()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  fabrice.derepas@canonical.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 24 Nov 2026 11:44:44 +0100
In-Reply-To: <d97e7b9c48b38c59023b8a8b18779b5c3318af2f.camel@linux.ibm.com>
References: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
	 <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
	 <d97e7b9c48b38c59023b8a8b18779b5c3318af2f.camel@linux.ibm.com>
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
X-CM-TRANSID:nRC2B0CWdlyfagVrZOAoAA--.19598S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDXF18tw1UJFWUtr4ktFb_yoWrWr43pa
	yDta45Ar1DXr97Crs7u3W3Wa4F9a93Ja1UWFyrX3W0vFn0vrn3uw1UtFyYgF10yr1Fyr4I
	vrZ0g3yak3WqyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANDWsFATwxPQAAsd

On Mon, 2026-11-23 at 15:33 -0500, Mimi Zohar wrote:
> On Thu, 2026-11-12 at 15:30 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > ima_read_policy() reads the policy file with kernel_read_file_from_path=
()
> > and splits it into rules with strsep(). However, the buffer allocated b=
y
> > kernel_read_file_from_path() is exactly the size of the file and is not
> > NUL-terminated. If the policy file does not end with a newline, strsep(=
)
> > scans past the end of the buffer while looking for the next separator. =
If
> > the file size is a multiple of PAGE_SIZE, the scan reaches the vmalloc
> > guard page and the kernel oopses.
> >=20
> > If the last byte of the policy is not a newline, parse a NUL-terminated
> > copy of the buffer obtained with kmemdup_nul() instead, and account for
> > the NUL terminator in the remaining size, since ima_parse_add_rule()
> > counts it in the length of the last rule.
> >=20
> > As a side effect, a policy whose last rule is not followed by a newline
> > is now loaded, instead of being rejected with -EINVAL due to the
> > terminator being counted in the length of the last rule but not in the
> > file size.
> >=20
> > Fixes: 7429b092811f ("ima: load policy using path")
> > Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> > Closes: https://lore.kernel.org/linux-integrity/20260814085443.1211989-=
1-fabrice.derepas@canonical.com/
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/ima/ima_fs.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 2a0bca554316..6d5e061f88c2 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -528,7 +528,7 @@ static const struct file_operations ima_ascii_measu=
rements_staged_ops =3D {
> >  static ssize_t ima_read_policy(char *path)
> >  {
> >  	void *data =3D NULL;
> > -	char *datap;
> > +	char *datap, *buf =3D NULL;
> >  	size_t size;
> >  	int rc, pathlen =3D strlen(path);
> > =20
> > @@ -548,6 +548,23 @@ static ssize_t ima_read_policy(char *path)
> >  	rc =3D 0;
> > =20
> >  	datap =3D data;
> > +
> > +	/*
> > +	 * kernel_read_file_from_path() does not NUL-terminate the buffer.
> > +	 * If the policy does not end with a newline, parse a NUL-terminated
> > +	 * copy, so that strsep() does not scan past the end of the buffer.
> > +	 */
> > +	if (size && datap[size - 1] !=3D '\n') {
>=20
> Hi Roberto,=20
>=20
> Why allocate a copy rather than reject the file when the last byte is nei=
ther
> '\n' nor '\0'?
>=20
> if (size && datap[size - 1] !=3D '\n' && datap[size - 1] !=3D '\0') {
> 	vfree(data);
> 	return -EINVAL;
> }
>=20
> That avoids the out-of-bounds read with no allocation, and it keeps the c=
urrent
> behavior, since a policy with an unterminated last rule is already reject=
ed with
> -EINVAL. Is accepting a policy with no trailing newline an intended chang=
e, or
> just a side effect of the fix?

As far as I know, IMA accepts unterminated policies via direct load:

# echo -n "measure fowner=3D2001" > /sys/kernel/security/ima/policy

# cat /sys/kernel/security/ima/policy
measure fowner=3D2001

This is due to memdup_user_nul() in ima_write_policy(). So this patch
aligns with the behavior of the direct policy loading.

Regarding \0, yes, this patch now rejects a policy ending with that,
but the file is supposed to be text, so I would rather not accept \0 as
ending (a \0 in the middle of the policy already causes the same).

Roberto

> Thanks,
>=20
> Mimi
>=20
> > +		buf =3D kmemdup_nul(data, size, GFP_KERNEL);
> > +		if (!buf) {
> > +			vfree(data);
> > +			return -ENOMEM;
> > +		}
> > +		datap =3D buf;
> > +		/* Count the NUL terminator, included in ima_parse_add_rule(). */
> > +		size++;
> > +	}
> > +
> >  	while (size > 0 && (p =3D strsep(&datap, "\n"))) {
> >  		pr_debug("rule: %s\n", p);
> >  		rc =3D ima_parse_add_rule(p);
> > @@ -557,6 +574,7 @@ static ssize_t ima_read_policy(char *path)
> >  	}
> > =20
> >  	vfree(data);
> > +	kfree(buf);
> >  	if (rc < 0)
> >  		return rc;
> >  	else if (size)

