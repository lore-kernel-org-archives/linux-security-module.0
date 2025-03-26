Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DB19049A
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977278; cv=none; b=hfZ2a3/bHUj1Sq/Z6bZCZtVi9jNitY9hRmQNrfiLUdRYhWrkxQuY9avTjJKcKUtIjP4WNO1Tepgz3ejqp1kV4A50deQHxZ4UuQfUkET4wrZzklbDfO/QhcI9tX9nAA6nUXgueOzIhYDqctc95Ixn8syke/FeY1N9sntPyJiPZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977278; c=relaxed/simple;
	bh=9vfRRuErcbdlUaeF9GV8S/kLTfrFKIbROPDlF30GRfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nImIegKi2eB+pfiROf6wuiB1qQmBVGt92vrTeTtviIFSQHO2euF+nSjgIacssy4/LICT7eqNv+BmzDON7f6KZmHI451U+KD1/bMGq7CIyFvmyHA5DojcWTqxTbLjyQD4KlYT76hnbh9jS7hPd1TZyHvZzajCQeHZ8WLTunbLNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=udVfEujQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aSRYqeWu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=14h2ReBy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OsfSALFA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="udVfEujQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aSRYqeWu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="14h2ReBy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OsfSALFA"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D31EB1F391;
	Wed, 26 Mar 2025 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742977274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6V5CBnrV527lNz9mDKdTcVdNwO9c8scmxLqBnIRrk=;
	b=udVfEujQ8Ul/CqavLoHnqpOl90X5hXST1JmowuIYtNpmsIgS3wF+9UkKMYqDH1DI+ym/ot
	aUk1lcBXRkLd3mfSlWSyx2ZANQ4Xu/jAqGqYRAVPA8AGSivnICAADIFG6aFbb1MhdPJfsW
	42UJVRT5dOxrnUjiPUnexbVag2TWYD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742977274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6V5CBnrV527lNz9mDKdTcVdNwO9c8scmxLqBnIRrk=;
	b=aSRYqeWuWhphq1Fwp5il6BoctzRzkCRRnueTJWopsBmf3lIHh+smKxLNA78FEZPTNkFe+M
	RK+UKQPL3blvgmAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=14h2ReBy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OsfSALFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742977273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6V5CBnrV527lNz9mDKdTcVdNwO9c8scmxLqBnIRrk=;
	b=14h2ReByA4xXRf5hdir2z3DPmzUC7SpLjttq9aVNtd8HE9uUtcP79oEVu0W1lrUpd0fHkd
	2Sf5m36U0wCl3DwBh9uB/eWQnAUnU85jJaAkOrVQHLcxJb2FjWZQupezv3ba096wHoRIy1
	x7uEg0+rkOHpPXb13XmgvgjLMBF5mEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742977273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ly6V5CBnrV527lNz9mDKdTcVdNwO9c8scmxLqBnIRrk=;
	b=OsfSALFAfNn7MsocWlM22gOSq1PsTHWdj52zmpF+fpdS10SttcN9cws7Bl1h1z+E5Pk3Tz
	Nj715A8IcOFepQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 303A613927;
	Wed, 26 Mar 2025 08:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M96QCvm442cATwAAD6G6ig
	(envelope-from <nstange@suse.de>); Wed, 26 Mar 2025 08:21:13 +0000
From: Nicolai Stange <nstange@suse.de>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nicolai Stange <nstange@suse.de>,  Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
  Eric Snowberg <eric.snowberg@oracle.com>,  Jarkko Sakkinen
 <jarkko@kernel.org>,  James Bottomley
 <James.Bottomley@HansenPartnership.com>,  linux-integrity@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/13] ima: always create runtime_measurements
 sysfs file for ima_hash
In-Reply-To: <35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
	(Mimi Zohar's message of "Mon, 24 Mar 2025 10:31:47 -0400")
References: <20250323140911.226137-1-nstange@suse.de>
	<20250323140911.226137-3-nstange@suse.de>
	<35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
Date: Wed, 26 Mar 2025 09:21:12 +0100
Message-ID: <875xjwrymf.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-0.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	INVALID_MSGID(1.70)[];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,huawei.com,gmail.com,oracle.com,kernel.org,HansenPartnership.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -0.81
X-Spamd-Bar: /
X-Rspamd-Queue-Id: D31EB1F391
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
>> runtime_measurements_<hash-algo> sysfs files are getting created for
>> each PCR bank + for SHA-1.
>>=20
>> Now that runtime_measurements_<hash-algo> sysfs file creation is being
>> skipped for unsupported hash algorithms, it will become possible that no
>> such file would be provided at all once SHA-1 is made optional in a
>> later patch.
>>=20
>> Always create the file for the 'ima_hash' algorithm, even if it's not
>> associated with any of the PCR banks. As IMA initialization will
>> continue to fail if the ima_hash algorithm is not available to the
>> kernel, this guarantees that at least one such file will always be
>> there.
>>=20
>> Signed-off-by: Nicolai Stange <nstange@suse.de>
>> ---
>>  security/integrity/ima/ima_fs.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/im=
a_fs.c
>> index a8df2fe5f4cb..f030ff7f56da 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -436,10 +436,8 @@ static int __init create_securityfs_measurement_lis=
ts(void)
>>  	u16 algo;
>>  	int i;
>>=20=20
>> -	securityfs_measurement_list_count =3D NR_BANKS(ima_tpm_chip);
>> -
>> -	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
>> -		securityfs_measurement_list_count++;
>> +	securityfs_measurement_list_count =3D
>> +		NR_BANKS(ima_tpm_chip) + ima_extra_slots;
>>=20=20
>>  	ascii_securityfs_measurement_lists =3D
>>  	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
>
> "ima_hash" is the default file hash algorithm.  Re-using it as the default
> complete measurement list assumes that the subsequent kexec'ed kernels co=
nfigure
> and define it as the default file hash algorithm as well, which might not=
 be the
> case.

I don't really see why the ima_hashes would have to match between kexecs
for this to work -- all events' template hashes are getting recreated
from scratch anyway after kexec (ima_restore_measurement_list() ->
ima_calc_field_array_hash()).

That is, if ima_hash=3Dsha256 first, and ima_hash=3Dsha384 after kexec, one
would have *runtime_measurements_sha256 first and
*runtime_measurements_sha384 after kexec. And both had exclusively
template hashes of their respective algo in them each.

What am I missing?


> Drop this patch.

Fine by me, but just to confirm, in case there's no TPM attached and
SHA1 was disabled, there would be no /sys/*/*runtime_measurement* at all
then. Is that Ok?

ima_hash was chosen here only, because after this series, it will be the
only single algorithm guaranteed to be available.

Thanks!

Nicolai


> Defer allocating the "extra" non-sha1 bank.  A subsequent patch will sele=
ct
> SHA256.  Based on the chosen algorithm, define the "extra" non-sha1 bank.
>
--=20
SUSE Software Solutions Germany GmbH, Frankenstra=C3=9Fe 146, 90461 N=C3=BC=
rnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG N=C3=BCrnberg)
