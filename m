Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827354;
	b=x/k2i1B3+oN7ekCuxYZFS7wuTdD1IW2FeGVfY2PEIBG/HfdBghbjfy6wkMCDYk8LQxsk
	 6DupfiF3jb/SMR8BBNnVyZIXDd6GR1FyQmLG8CaThviJuU96RDQ9nG0CHcalsXpcMFZBW
	 Hv+UoKTh3GAgzjnB/0rf2RxeNUwvVQjOPk3k/2tmNfCnmXWXAgVk/zmcHdrxEWvw4mgRj
	 hDyo3IcqO8cy4CtdwMCOg3N1VZcF/CumzERGH72TW9gEFR5lUR81aQXsEW8UaAuRDgcqM
	 HGwcea2qx/EE35DcczXAV3vEVtfr2oDU1EakAcoeUNqbnfaDPIOVL+48i8G419D+Qnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
	b=xHCltEFCJXk5GtpjABIQaIllGvpBnIyXWSSlyaI83oUyDh2h9GwaM2dGeZcqHe3k2ym5
	 Ch/goIyGXrHRvU+WYuXe4NS78jj5lil42yBmSrq/+NkB/v0hBi8fv8Cp58NwkIGdkB6Jh
	 Gnhr9D2i5RBaSD3XrXSMIccPj8tE5+iFJj9rheDhoagz/BKFrHyTkZ4uSuy9Qg1jwXd+z
	 ztrwsLlFFNS1hr36ASVhS7rQy491mQrPt8FeaW9d02bGMAxqLxeUYRyocKiF5zMNuW2R/
	 mZTxcMRZK3XfQhAJSUDYrnowwXBBNbvXLb1yjrHKedbKru7cjuo0F1Se/h529kr1luw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3597606A31E
	for <linux-security-module@vger.kernel.org>; Sat, 28 Nov 2026 00:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3597606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egc5oRyU
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so58026665e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795827352; x=1796432152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=egc5oRyUW6VFDIcdxYwZDeGVcRPdqVVcw0/9bUs8kD5ZsjJsFc0wc7Ij4lq+IUwayF
         w2XgNkLL/plAb0xjtXjWDmbgHsj8BbN8y5QH4zabvGdDwwb8xzCpvOiS/FFDQ1pAmNwA
         4uiU6YjDORB86waZuFacytNoIhdLmWlhX93TlunzFDHBxP1tk3JWqemA4JUyNxNFOtfh
         CKwdIz1EOzEmUqFvrYxqw/6yXUkip8rv4zUWrx4HDc3q++gCUskaW4sXZoxU4kXNS894
         nnM8O1l8kivUFX2WTqpxfjbMSvlGbzGIvqyGbP1cvEGn8taKbCLd436XionhZ+TbNkl7
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827352; x=1796432152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4YJXz2C1qqMpFfvawPlwYq2ZIDKs+0ke0HB93yAMqs=;
        b=gPJmxcHa6q9ytVzE/lAVStD2jfy+cm2sEHrViZtVmnu8ub2tlTLR0DcKe7HgFH5NJB
         WQXqESz2kEhEW4fX2gVJ3XufUjyiv9wPMH5U2Xq94STNDkUeTeGRmoaASiw3MIL3qwlf
         JbbKznNWxAKQbG2hlaHmE8HNeAk6z1rroQKLJ++gpafg0xA9QN9fV33t6c7r44TjJVLc
         8G1eZaI4Q2MwpPm2/oiPZ9lOClUNBLyvrB3VDyMc3ev3AVLagwpAFP0sGHC0Se2RtoN2
         7R1BITV7CKh0LR9dm1HyrGJBKjwrAgucY5unN5qSRlMI1UkYbBMUU9HA8dsoMSwOkFJW
         cI0Q==
X-Forwarded-Encrypted: i=1; AL+hErHREsWAfINNKtfS7wxyXHeOGl0np+5337VgQoi2nwVm03fxrwZW1VhpMQ1Y+IiL+oCzPuJgg5QrgzdL6YYc9QUN2GpJWNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q51/tMw6wu29LLpl9Ndrh0wEe/AfNG33yyhaPGb0Xr1t4CUga
	fHo5R6lWSE1ewDvyw2yR4Iu86xyC9lX3CiwaJpRgefQC5fRxrF5DBV7W
X-Gm-Gg: AZFdTZfmOZ9uX4jP1kqDJX+Uq1z8DXmMNSvnAVwtpOIJNz08D2S97iTCPRf317cEHTJ
	CSfE6jCl4qZGb8Az3THSzSkTYDbqDjMpX98c/SQlI1l+Vg45eXlbYWvVIo4q5FaSzSvUBY6C4IO
	DNT2vioI7Nljr1/PZo7ut4akDpRdMEoY4Hy1kERyx/C+B20VOMVxghr2S10N0Xin+/tfFOQTRh0
	cBCkxXLZxj8FhhLzcqHkUUJOqgC5fAUwHhqoGS8dqeP2a+0ybcCCPCEnvNjRA4mTQugvykewmNZ
	hczlx1GwtisDGudvWNrg5HdJrN+AEG6WU26bY+GV0Z+aaUdkjBlNV3f41BERD86hMWY4cq0lF+D
	42jutEPq4l4rqVcZDhxA3ncOORDGREmsHiOwnTrYq4ioXfvSu3ANYsUfzCCawOcS7dldsn6rIgK
	78Coknw7y97vBseL7w/ZSGHN6zc06JbyM8NkRrCYQ+TovD6Fvf65mbYAeP4rNnqeZTgRcNdDLdt
	f50F/69fjyOWB0c78TJEFRE0xdXWPnuVnf9/n45XnBZCywMmNifCQyg8xzSqpzjOBPNRIqierz8
	D6NWygzxr8bpCJyrwJsMUZuNMg==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr541218935e9.32.1795827351797;
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b09bsm1328407645e9.4.2026.11.27.16.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 16:55:51 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: jarkko@kernel.org
Cc: aleksa@amutable.com,
	alex@amutable.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	containers@lists.linux.dev,
	corbet@lwn.net,
	dhowells@redhat.com,
	ebiggers@kernel.org,
	giuseppe@scrivano.org,
	hughd@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kees@kernel.org,
	kpsingh@kernel.org,
	lennart@poettering.net,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	luto@amacapital.net,
	neal@gompa.dev,
	oleg@redhat.com,
	paul@paul-moore.com,
	ptikhomirov@virtuozzo.com,
	sergeh@kernel.org,
	skhan@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	zygmunt.krynicki@canonical.com
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
Date: Sat, 28 Nov 2026 03:55:41 +0300
Message-ID: <20261128005541.873229-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261122193539.3334213-1-jarkko@kernel.org>
References: <20261122193539.3334213-1-jarkko@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jarkko Sakkinen <jarkko@kernel.org>:
> Work on this feature started in 2025 after reviewing David Howells'
> container object patch set [1], whose underlying mechanics made sense to

> [1] https://lore.kernel.org/all/155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk/
> [2] https://lwn.net/Articles/1102593/

You put wrong link in "[1]". This is not Howells' container patchset. This
is Howells' fsopen/fsmount patchset.

Link "[2]" seems to be wrong, too. It is not something "earlier", this is
very recent LWN article.

> While the patch set is manually written, the original motivation came
> from isolating LLM agents

LLM agents are too strong for Linux containers. They should be isolated
using VMs or using some Linux reimplementation, such as gVisor.

Bacik said that he tested his patchset in Anthropic. But I think it
was tested not for agents themselves, but for something else.

Anyway, I suggest to drop this phrase from your cover letter and think
about some other use case.

-- 
Askar Safin
