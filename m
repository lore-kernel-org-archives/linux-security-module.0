Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766540;
	b=D/scSNAKwbMCQP0Iqz7QELOyvzdRFIrhI62VjfnYEJOjjzAiHOuLfnvRid4kd287DkSu
	 z4E4Jru5oJtGiiMfEoJ5EsMNTLTsypQ5UYurdpAYqmaLGoSgIIX2vGBvt9MRK8/2wDFyl
	 R7sf2Xhb6Xx3SKvyed1FLUluzGzL4MrRXQF8rK+ju08eSf22aLai1RQ7VjfvEeKIIF2ZH
	 PxZz/Aprjz/UKwel3x1VVtIU2wqTdMuRVQ4bNT/0aFK0s6LwXQvcFW2AdcMu0f1kdWZbe
	 xl0I8YBq/kFkrBqWEnjSxEQ+XhrwcbgCYfGCn+1P5Oo7b7Ybn+O/hb+SyUJDahiSbZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N2OEmweWJEayBEeKAuczidb4NSVYA6dW/ggSFTV+K7o=;
	b=VDt23lmWLePjvbEoMhnveP+I0d0eoiPtuTk0u7IX75sY2wpCq7r/jMMAObM/5YH2zZ1A
	 sPMx78jksElDWBKLIcFGlP+PeHk6TfPY8zaIKEqUvKtp7SFOm8YoYd7ovkCEce8LSBUIS
	 TZcfThp50O2Eg/v88k9SSCBAtXvzTD1/2X+dbzDR/bW/FHoIgPoo0wLxXuN6T1XfiUFFL
	 ZkhWx42NkHqZPKYo3BxbQ9XJ1P9PtsyC3x8KVjN8vTsH7JLr/A3nXRI6zGTZgJzBcvUKo
	 lEzcFq1X5lp2RrumTjAWwvkVs7Dbtup2VBQPQ3gFiFUSmkSUedpOEwYoKj+Vp4GsXiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSboFVQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1812606A32F
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSboFVQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52321F00898
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795766539;
	bh=N2OEmweWJEayBEeKAuczidb4NSVYA6dW/ggSFTV+K7o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TSboFVQbL/SY+GP+Rm1XdyH45/capsTiwRcehmUJ1ZwRHl1TplozAys4cTjMR/Jwx
	 n4fHr6v3f1pvEyqnPi0o4Tu0GYdjgqD5Xj0xn/5gBFeIBODkZEQrCT/yutQx2vYfGB
	 iFAFlDqOPrfkp3QnxRSKdrMhxH0HFGDx7cEz6wLMcWD2YVEf2/dtj761gw71oPXsEp
	 f2ZvO9bYtt8xy/LxcH9hjo8ksL5rkEllgWiMxT/5IH4H5giEDZXy3jkFcchovS3Dvq
	 f5b0MyUwU1hWfcFZnCPGCnMdTRkPGoNSUOvQGDomoTIhdZxix6pcOJGijnx0bE5SZ3
	 oN3TvYaAh7TWA==
Message-ID: <sashiko-outbox-236853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: allocate the new hash table before detaching
 staged measurements
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127075732.252471-1-congnt264@gmail.com>
References: <20261127075732.252471-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:02:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] ima: race between seq_read() and ima_queue_delete_partial()
  causes UAF [1]
--

commit 45f3c9a66f0bc27f297aae05dcd53c20818ca3ef
Author: Cong Nguyen <congnt264@gmail.com>

ima: allocate the new hash table before detaching staged measurements

This commit moves the replacement hash table allocation in
ima_queue_staged_delete_all() ahead of detaching the staged measurements li=
st
so that allocation failure leaves the staged entries intact.

> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 0f1b7e4113c4f..8225c35cf709b 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -377,14 +377,6 @@ int ima_queue_staged_delete_all(void)
>  		return -ESTALE;
>  	}
> =20
> -	list_replace(&ima_measurements_staged, &ima_measurements_trim);
> -	INIT_LIST_HEAD(&ima_measurements_staged);
> -
> -	atomic_long_set(&ima_num_records[BINARY_STAGED], 0);
> -
> -	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> -		binary_runtime_size[BINARY_STAGED] =3D 0;
> -
>  	if (ima_flush_htable) {
>  		old_queue =3D ima_alloc_replace_htable();
>  		if (IS_ERR(old_queue)) {
> @@ -393,6 +385,14 @@ int ima_queue_staged_delete_all(void)
>  		}
>  	}
> =20
> +	list_replace(&ima_measurements_staged, &ima_measurements_trim);
> +	INIT_LIST_HEAD(&ima_measurements_staged);

[Severity: Critical]
This problem wasn't introduced by this patch, but can [1]
ima_queue_staged_delete_all() and ima_queue_delete_partial() race with a
concurrent seq_read_iter() reader and cause a use-after-free?

CPU0                                  CPU1
_ima_measurements_write()             seq_read_iter()
  ima_queue_staged_delete_all()         _ima_measurements_start()
                                          rcu_read_lock()
                                          ...
                                          rcu_read_unlock()
                                          return qe;
    mutex_lock(&ima_extend_list_mutex)
    list_replace(...,
                 &ima_measurements_trim)
    mutex_unlock(&ima_extend_list_mutex)
    ima_queue_delete()
      kfree(template_data[i].data)
      list_del(&qe->later)
      kfree(qe->entry->digests)
      kfree(qe->entry)
      kfree(qe)
                                        ima_measurements_show()
                                          qe->entry  <-- use-after-free
                                        _ima_measurements_next()
                                          qe->later.next  <-- LIST_POISON1 =
or
                                                              stack list he=
ad

Once a task becomes measure_writer in ima_measure_lock(), it can issue
concurrent pread64() and write() calls on the same O_RDWR descriptor (or
across extra descriptors opened via measure_writer_extra_writes), because
seq_open() sets FMODE_PREAD and _ima_measurements_write() does not take
seq_file->lock.

_ima_measurements_start() and _ima_measurements_next() do not take
ima_extend_list_mutex and drop rcu_read_lock() before returning qe to
seq_read_iter().  Splicing entries onto the stack-local
ima_measurements_trim list (via list_replace() here or
__list_cut_position() in ima_queue_delete_partial()) and freeing them in
ima_queue_delete() with non-RCU list_del() and no RCU grace period leaves
concurrent readers accessing freed memory, LIST_POISON1, or the stack
list head.

[1] https://sashiko.dev/#/bug/linux-ba0e31a8-a909-4f9b-a571-5f4d11ef4c91

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127075732.2524=
71-1-congnt264@gmail.com?part=3D1
