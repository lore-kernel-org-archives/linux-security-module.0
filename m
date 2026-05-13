Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B928B3ACA43
	for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697389; cv=none; b=ZR0vHp8q7pjAzjgpN9hL5Y98P1SGUQxSovzrCsRQfBsxH5EsWthMyeItnxo/xBqaT2KdKOrGvt0TK5oNuR+EIbRDgW40BPvUSDqL72nxdG8zQh/sVXrHb3XrojrG7LomgsMV6q/D5/wh19mcUw9CwSdN2VXVls6w8egBWIf4tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697389; c=relaxed/simple;
	bh=AwM9cJRmcVcStEw5TEKGWm73QdLaxIwl7c+W6VAlCCg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=g/ZOtlrehw2/qSfYz6sUYajSdszSwxLPvtk2TIuOfkVQ9kXNjG+3OMK8vBNC9ii/sNz0q54AQXgMIDOUK/zuVxZVHiqxwEXgZDblA7waPW/AvSD66wdJbQesGa3DirzA9Kv8F9sETBAZ71PMpa/V4M48R9V7uZMQnmVaYvaWAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cD9oDTfI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cD9oDTfI"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cbc593a67aso632880185a.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697387; x=1779302187; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXBweUZx3jqIrVzTdHurGYke6t/WyOEmRQAf2KrWVaM=;
        b=cD9oDTfIYT1bfyD2JwneiXjHGdC7t9/bNzI4gN1HdbDcl7YcfCuWCZ5N5zKVTabveq
         hbequyQVPVigXhC1tEoouH1XapFTWsX4N7s9peUNA+JTSVxMJpm8b8jCNUSvyYuCfXqR
         RUIDWtMO9eCCOosCBxY8Gj3ec4sgvteQOKkp8DrRfP+O5ITWBdq3LDrKVt6LPBDifttH
         M6koMy1l17tS9cRwl6CXYxdAY8+7hmJC2AsrWV60HGEBU+gjxc2CV2sE5HeMO/ojwF4Q
         JHmKNfWsNYzqEWsSHF0zjFFTVnLvjfOvAo4fAMAL/+DxvCxtJ7ZkDPKIDMnQhO86o0z7
         9BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697387; x=1779302187;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXBweUZx3jqIrVzTdHurGYke6t/WyOEmRQAf2KrWVaM=;
        b=SEuXzxAu8rzkGDZylQQ/vX+phOibUGpP0zCfuH1BC0WiYgn6m/uIZuDZ6RsA6YfZYe
         kohomRbhhUzzDnNjUmL9pO7v4Oa95qxUpafIq5INN3mBZVjSu0XXz2gsDCfRrlEEHW/8
         37IW8tr6WErNIV5JTKugYZdyKDfje0eb9WCWtMxMwsieVftoHoZNCY6/CMpZRVAY7G+/
         /ObIo6kIcoiTVRpzpqfDHVQU7NkUPQiorrOwVyYStKbicU0Hba+BBpQmbjhBfTn/hU8I
         6itjmK6MDP/B9Q3gRjRfZBAALuU4zETBB/iqJccM2h7X2RKe9LlYKgQQXYbz/M1dVC37
         qxWA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ygg3MXrk4nQppfwAeNFD1lNKW8Ceihneu30dCn1e7ukVK3hU3AlzQIXJ+/zU2WpzsF0szhsxiP83IUm7LFYWr0cegoCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4h3+fCsnD+FhwPYoq5pb4I1fB5RgvGbshlbfsMMaw9MCbwjy8
	q1fTLYNPhflq5fBUqCsz8yPNqkAN4VNuDlKpXxybiZEqJWm0qhq3jQsWnrS3+jxt0Q==
X-Gm-Gg: Acq92OGyNv1iPI2hFJU53CgceppZDMXQwoq0B65aD8BuGd1txPIFHychcjJ2eRIaidK
	mpdfRd6vL8mtioUFdlue5GBDg3G6f+Nwe6aCXC5IRYY2pl+yhUPFfFJjjW2AjwFuA9Qb4BGAbYc
	6tvvC0GbafNOb6ZU92hboguZOJ0UwZusDA2iMy8BxNyck2myWwSg+ldLDuBa2V8eAM6iMP7srsX
	BGHUhVTkxSqCs4pEshBgqiyO9t5Zct2+ffguPjTcAMkW9CWG8D37QL3uVkTuMiFL8EyiGVSC7vA
	hToanL9tMbQKeibCQXkxDZRhZLuEgmjTrHvXESowbscPO7+ZriEmIr+9kjiAFEdJ6eRX/yacaXV
	vETajHxJiu+n628k4ivj78Z04950r2fIFsZ19KGcxGhanl1fMLVhhfUoLnDCXBCQKKARAlWywZp
	s2pbNqhvnnQBC9S7JbGjFDSDvbnvSlghkXOvvuRN7bvQIr5TrUNRkSnXSTnfEQTJmaooFZj94qE
	nRKj1w=
X-Received: by 2002:a05:620a:4403:b0:8da:e62d:888f with SMTP id af79cd13be357-90f8ad0a495mr680403485a.53.1778697386562;
        Wed, 13 May 2026 11:36:26 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83f926sm31771385a.30.2026.05.13.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:23 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:23 -0400
Message-ID: <c27b6ff5e1f47b0240a92610c1aa4b88@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 9/10] selftests/hornet: Add a selftest for the Hornet  LSM
References: <20260507191416.2984054-10-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-10-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This selftest contains a testcase that utilizes light skeleton eBPF
> loaders and exercises hornet's map validation.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  tools/testing/selftests/Makefile             |  1 +
>  tools/testing/selftests/hornet/Makefile      | 63 ++++++++++++++++++++
>  tools/testing/selftests/hornet/loader.c      | 21 +++++++
>  tools/testing/selftests/hornet/trivial.bpf.c | 33 ++++++++++
>  4 files changed, 118 insertions(+)
>  create mode 100644 tools/testing/selftests/hornet/Makefile
>  create mode 100644 tools/testing/selftests/hornet/loader.c
>  create mode 100644 tools/testing/selftests/hornet/trivial.bpf.c

Merged into lsm/dev, thanks.

--
paul-moore.com
