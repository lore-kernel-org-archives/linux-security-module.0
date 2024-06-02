Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B26DD08
	for <linux-security-module@vger.kernel.org>; Sun,  2 Jun 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359089; cv=none; b=aaEQRhEeca34x814LSasvnpjgjTPzzSqOXI7LhmAiHqfl76u/SskNhNhwGkZ08rHY9YcvyA/8xYVysNJPVAh8HPqvj/bEMn8BHpUsyFxiB69rqgYmb8YWfdKZCDXlsg7jDzaHFa5o1ejpQumhwAampHrZcC4R5soALQ6W5Dc9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359089; c=relaxed/simple;
	bh=pPpQRofU4aUuWzH8F/QKbmIvQmhWX6HwGWlPQg5XjJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbox+ji2P3O8yRQbXOgFjJGrq7gaaISEAiz0L8Z9P+UHK4KUxxF4LGj7qz551nEWWjoYDgPHR0DsRxDWvm1wDHH5TN01jVjPoR+UFEkbQbcRK/yZMtS7+N9JWbl/NpGCMx+VRHVEb/5r7EqC7bE9RpdqfoaCPUaZVG6AmXX6dNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TF/kv0wr; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TF/kv0wr"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b8254338dso4199075e87.2
        for <linux-security-module@vger.kernel.org>; Sun, 02 Jun 2024 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717359086; x=1717963886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=TF/kv0wrvU7CMD/1W6pdUuFiz9Lbwi4grNGC/o0BgG9oAogSjQmTfmkE8VCpSAcYoZ
         5jDtGz0A02AyWPDSM1vbeb8dBu+Czmf2sPpMXUPNC+OD2CcK8oA/3/wUhnSMDNuwNqjM
         T7IACHmfTs2o3k7Y2QBqEiFfXliZzGut61kEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717359086; x=1717963886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePqimL8VaYhHEJxz6pSQAbNa/K23yw/URyexsY++IVA=;
        b=exS2Z4iL2QFWeTwQSktIyx6NypENh3KGryUhtSclSZYXHYOHKqaRa0swu0E51GhB5o
         gQ04vNyDzFRJWz60kSG8ze+HbE8qMQrNTxlrF2dQKHi/AnpcCcvW0LtJf6ohCdsLGkg6
         0UFqkIsv0B3SfSnbDPCjbNN18iH/ThiwK+Cxg0mb5XULMqDUCoErpgs9hjF6lITrSOJ5
         bVyUHllS3LnoeFlHwD8NQLtJqgtwZyhZKVa4AbJq0lP5GTtD8ucf9drGejwtnoMzyhyC
         XKIkNBnYI1Aza0m/SymPOH5lbVB1mFq8+Wjl5K1Tc9ql/MhzJZICnfzu/lrkad5QtNLY
         dzLg==
X-Forwarded-Encrypted: i=1; AJvYcCUN2t7Z4KbwTXb2fvOdR6LUv7HSlVuxlS5JR7AwjgAcdrPrZlyiAuiAXj5sXQupIWZWX9Bmh2uFNZ/N70hwmbrmrKfjoOa8RDD9rr8eYVGUhIMpknWs
X-Gm-Message-State: AOJu0Yzw7rrDbGVK8vEbnAaJJ6bjRIyES4ImslvX3iGZdNphCWP14GaL
	Q9IRrwrY6FJ3Y5CG2avdxVTkUFJED+DX8Yq/utcZPjFiAq3w+1LTxYdsZ1+PrTyv8oRKsrWDdLl
	p
X-Google-Smtp-Source: AGHT+IGzLKi44iBsAz0N6wz4Jsz1jeAeUyS3GYdtVmmE0x36v5chchyQNry2sLfGzZ7l3RG/kq9W8w==
X-Received: by 2002:ac2:4822:0:b0:51a:d08d:bab4 with SMTP id 2adb3069b0e04-52b896bea15mr5797465e87.55.1717359085864;
        Sun, 02 Jun 2024 13:11:25 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d760e1sm1009220e87.153.2024.06.02.13.11.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 13:11:25 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc466fso42210511fa.3
        for <linux-security-module@vger.kernel.org>; Sun, 02 Jun 2024 13:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPlBpWe7PxeEXdxxq+eU18Kwo08khs7LTldz639lwiGV5KxCas5eoCYg6XVHoWskM2F1OXTcp2KrnMr6maBgN5ayaGEHKuvDbj6nFCXE/QWvHvzatR
X-Received: by 2002:ac2:5dc3:0:b0:51a:f689:b4df with SMTP id
 2adb3069b0e04-52b896bde2emr5480833e87.44.1717359084107; Sun, 02 Jun 2024
 13:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com> <874jabdygo.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874jabdygo.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jun 2024 13:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Message-ID: <CAHk-=wgkgtCjr3aHFnFifYtKnvet0M9jehfMFYhYpL_F7Jbmtg@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Jun 2024 at 10:53, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The read may race with a write that is changing the location
> of '\0'.  Especially if the new value is shorter than
> the old value.

It *shouldn't* happen.

So 'strscpy()' itself is written to be NUL-safe, in that if it ever
copies a NUL character, it will stop. Admittedly the byte loop at the
end might technically need a READ_ONCE() for that to eb strictly true
in theory, but in practice it already is.

And even if the new string is shorter, the comm[] array will always
have a NUL terminator _somewhere_, in how the last byte is never
non-NUL.

Now, the only real issue is if something writes *to* the  comm[] array
without following the rules properly - like writing a non-NULL
character to the end of the array before then filling it in with NUL
again.

But that would be a bug on the comm[] writing side, I feel, not a bug
on the reader side.

               Linus
