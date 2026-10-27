Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113313;
	b=GANHMnW/QoqZqs/jkr/mX7RnrTpknbuyMBhyg7P7bOBYvXmLtumN5fLoDwGvQmPRtFQ/
	 TSiRc3zHaRt1TrxLrz7QrmfQgxqcacWQrQg9ir83lKjsZbMWxsrk0OkZ5as736wkaGG8o
	 all/I0W0R/4MKDKS/YtuUhghk/+KZHt47v0o6nt8SPFAVeQr+FwfQpCyyQRcW76SM9VYp
	 qA7i1Ex16TT7iOM3tctTGAH7ouWaAZuGsmckPY1FWo2N6cutLx7LYaaehL282okzxJQrt
	 44fAfXyO9rcJwZFtTIcMsyevQTkoCQzpeFdB7zxqHdluuKk6q7CzWFemu2BZnzziveQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
	b=RQ0TtMdNr+RmMoh0EGZUPfqz1fLPRi5n8Tx7/xMMHcaDC3uEDZwGcVvy8l0s7tQfDjKP
	 O7Moo+Uj11qZwwBCtzyyiqX0QlKMmtXJBYZkxqn9yA0CEEsUCNqLxnIft6rY2S9EtJE6k
	 uLDy9eoljDzFezqP1NIekWF6986qIiuWTb8tfv787tY4qQ1LF0q6lQKsjxo6HVfgKnB8w
	 70lKhFhiYJikJNF60Qy/77xHrE0Q4YDTyUSJ1xzjU0vBVJpREotBrin1mshGjexryG1g9
	 8lwFfCiQ5GSt7Zhf/qkX9V0HJMPSWJd60hc0rD4M2hW9Nu9GmOLLe0AvwIfplr8It9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B1606BAA6
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 15:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7B1606BAA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4RCI7rt
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so19488a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113313; x=1793718113; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=Y4RCI7rtBOy5b9y0FhCXLw7TxjLGKoqP7U6NlrFD6q8Ld/t9Vb2wuRj4d5nvLDYNmW
         zMd4eYz+V4fCXjWsiScL3PR0/jOkJbs4iZB/1XrWm7L4dnIYl6zkHE/78s3Hrx1q6Waj
         oRJIZTMGG7SO+raSfVOtWoAkLKKYIlEQb+1KLlQzDppE2+agB1IrvZx0fPK0fPBmKjT9
         tmPkvXERI+kZg+dU9H69n1AXCmu2e6B/KgFFjnm96LtaYjcsqwxw+UdhXxmTEqT0+3z8
         iwxmEvIrStDaVsjlO8tSuKQpCLA7DgHptE2QvFviEIcgFaBknjMXm9B00tSUipyu0hGO
         dOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113313; x=1793718113;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4JSSeMn7jD3hzJLmiAPL5D8xsSZOgnxpk+LkLJ9f9Go=;
        b=pqJBE3fdS+6Bb6MASlCkBIEvIsgih5kotVx0RS1Sk/JvOM41fMU7ZEV0nrEOpp0IVo
         g1IhhYmgJLGdP3iI4CBZzl1rxZYrUQx20dnYQ7zZeS26mfERQue0dU6JpIKNHL/G6xYg
         /otogjBXrWtUlhvtprEep/t441qAxI3d1BMBzkfgspGMb7Plnweg8E+UEE/hhrLT8Ul1
         1f6hIjHJNYRdQHCsRO1Q81hiv+cqRDRwaSaxExlGeXOtstVx+jZ+edGeZhNQxW6Ne3vN
         SQVgMXdP7sj6NuGK7Nlh1cgr5H2k47PAAcye0lckdC0I2aUIUhhgm1+A6gn9NSWDDYxE
         rKkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbImDk4z5eDyI5NaVDc0XgqbN4QQm6sB9W/jW5AhwxGPubkcg7kySf/eZTmkr+D+1ifze0J4DwjeRL8oYaI2AnRG/RwAk=@vger.kernel.org
X-Gm-Message-State: AFq9FYISBqs0Q43rN0VbZ7pYOXpiU6hnJH9r6VyKOemCYM9JoK4Ylg+K
	PjJnEoBbEnZ851A49uisXsyiOhnozOCjBs3z9h9Ipqn4LF0jnOnKuXRt
X-Gm-Gg: AYBFou2Ck3HweWChztfS7XHooogn6Md1Xv+nvg3MS/rTDAF+msGpjRCPpSdlNUoAAMW
	I6DivpR5zIWjsRvV1oZmjJsXQ93M3wkfowekIhCCe0rmrzFHUG9nfIgjokTB+tovOYADB2OKUDg
	w5cL0jYeVZlnrda0smVGRBLTgf7kzCwryM/hwnv8w11AAcRYxEju0ZiwmxqArYLQCeIwgRN6rsw
	/Vfu4KechdWkC9SdwhThUJurR0sCXxngLgHkRzJ1PZ5LQNEeSh/QiUsraEDEmoIml/g6DPZWHWO
	bPNQzdsm4criGPVg3qh28nZcbHoXT+yaUINGgxC3vAeUAyicLdVBaJn/LkPOGlM5xFkQqhXWM3H
	ac9rMq74KFGoP1bXQcPeb8cfSahQLTW6Tt7at1Uh8ZcSc46DjdYyZUSzC/9NyMVyohGcqEWnlUc
	Rq1L7rI2svBRB2Miobd2bk3kyeOQYIaKEnEj1s6mwcBj0XQAhUEM/2wJC4jSOQmIBcLBBmf32K/
	OfQ1bXkh44//fFTJKlMFfjBNCm6s+Mo/Ht6nsp9SG/0H/KGiOdDGREUjWMh1Mf7Gx+ycYDNpOz2
	By1Nx4wYChsWd6VZC+XxqO2Rh4kle0bQBJvDkPdu7iy5M0HLjjke5TeTbY2J0bmwsMM3fmZqHOE
	bHb8FgW3Wp49wV33+MdoYwzWHAaBYCynLS9BiwHP3YuJXHdq+96UwewA=
X-Received: by 2002:a05:6a21:71cb:b0:3e0:c102:33d8 with SMTP id adf61e73a8af0-3e7cd5014c5mr6505768637.56.1793113312516;
        Tue, 27 Oct 2026 08:01:52 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccd63b6sm2848985a12.29.2026.10.27.08.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:01:51 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 15:01:50 +0000
Message-Id: <DMFPMAYUPSDU.2AW3225P0W0ON@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Cai Xinchen"
 <caixinchen1@huawei.com>
Cc: <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
 <dsterba@suse.cz>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Subject: Re: [PATCH v3 -next 06/18] LSM: pass struct path and struct file to
 the inode xattr hooks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261027121151.1887650-1-caixinchen1@huawei.com>
 <20261027121151.1887650-7-caixinchen1@huawei.com>
 <sashiko-outbox-186599@kernel.org>
In-Reply-To: <sashiko-outbox-186599@kernel.org>

On Tue Oct 27, 2026 at 1:02 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] bpf: missing __nullable on file arg in inode xattr LSM hooks=
 allows NULL deref

bot is correct.
Please see commit 94e948b7e684 ("bpf: annotate file argument as __nullable =
in bpf_lsm_mmap_file")
and add to kernel/bpf/bpf_lsm_proto.c when args can be NULL.
That's how verifier knows.
