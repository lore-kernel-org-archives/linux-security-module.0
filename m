Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5B6F2F2
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293253; cv=none; b=M5tLjVNvtr4F2agvyOcnEmQ8DebO68VOibY77AEOmTJ4dbboS4PK2/3IURyz9t/Km9MWRT6Hu8ALN+d4jcct7vt35ItR726x7rkEBtUolGw55pRR5gwgA4BKG9kepLPmJ6hBApESZuld9Z+mOZzPL+qIBxGbKdKFDtti3hlZp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293253; c=relaxed/simple;
	bh=EUbyPSPzg8O/FCruDlcxDBtyuxWhSzYDy+sSVCSNiwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sc3T2uoMBJYz8EibuNJ9s7c+amSmqhR8e02j8iV2PwRPqxXM2Tu17xu5d7yv9G/Cm8uX1YYU0daDI6wQ8GuTtAy9ph6QRPgpOMUK8RLMiI7x8v0tq1swnBUWwqq71So0e7P9GCv7hdjs/5YefNpBYCAUckcgWjwP3B4+gsaNKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAbW9UuY; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAbW9UuY"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42fdbba545fso1754307f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293251; x=1770898051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiRDpPfBdhyz5wlzzzVx6PwkN51eGtr6n3cy1jg4OEU=;
        b=PAbW9UuYnetR5vDfvxtaFul/hV5JkM7tan3qTmdfmFByLa/lpdG/ghUyLuOoA3g65e
         c+A8y1QaDSMbocnhBddBrpXMPtEjDWr2cZNt9NtGsf6m0b7yGkcH3Hvd3UCjk4apEhjw
         u/zBfrOTdCWr03V9Z6I4cT3Uu3BtQlZLdjl7L4G2KUg3JZ/fBq1J851kwyETl+sTEIBA
         lLfP+89WqO6ssKux6qqCKTtJhu6dmgnbMAAGBxO4vXxAcnrCMBEqf0m1lMzEO9AnRw0R
         p5Uz2DLHxBIOSOaJyuEDG00L7i19aFtXxbYH1RKMLa4xDD4jncvyVnrfcUy90MgPqnjp
         4Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293251; x=1770898051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiRDpPfBdhyz5wlzzzVx6PwkN51eGtr6n3cy1jg4OEU=;
        b=bqkvdP0lITZ9xC3Tg7SS2T31dxU9/M5CDtG7mSuHdIHgRXvbOwzvxbT/xb4wz0O5rp
         SWEPxPkeGunPrnpEUiBqKTUBY6tyGoHvto3gJnfL7nOHu8BL6tOcBhOaaNhrnujGFdgp
         89ePtrnUrlRiYntKmqf8ZecdNiHqYMSp7I/Omz3GKB8MDQWLw3VQOavrCutwji722F9Q
         nkAkMJ5etzajy2x2k2jTM+ycqhH79L9ip8LUolCpy1hKWbCrSiirZ3VMfEnD4e0S+SM0
         bCyj9nLBYwzbno8v6WxgIiSt3EANHpMNMbB4RVzV7OsmSsqFufM2dlMDh8+/lxFn0A0e
         h1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUZVUGK6URt5zkskW0Cznk4xtSqMibYufm1wGuoiugf0MYiwijmSuhGbCaYYmpdzcLfvNov1WBQ43VXA3RscBFO/DdQWC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsSbrx1jnMdoE7iKPNrhdtxPgB+m/Jm2VnhyVKQxXx5qfOfNo
	5p9boNPKgMMQHjr3MQAx69tQekUdT7KBcMe4UeUu6QIP5t6QA6Zl9xaDTrLS70kvZ0Wsnyfvbzr
	3nzCFPKUJjz6lz7Twkg==
X-Received: from wrbbs27.prod.google.com ([2002:a05:6000:71b:b0:435:c29b:f782])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4201:b0:435:a135:777d with SMTP id ffacd0b85a97d-436213d7b3amr4150152f8f.9.1770293251034;
 Thu, 05 Feb 2026 04:07:31 -0800 (PST)
Date: Thu, 5 Feb 2026 12:07:30 +0000
In-Reply-To: <luj2ggjo47mvjzhzavoy72ro6kaoj46cicudjrc6646vs3s7q5@wzc7aabgdlkl>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com> <20260205-mitschnitt-pfirsich-148a5026fc36@brauner>
 <luj2ggjo47mvjzhzavoy72ro6kaoj46cicudjrc6646vs3s7q5@wzc7aabgdlkl>
Message-ID: <aYSIAoK5KkZ3ver5@google.com>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
From: Alice Ryhl <aliceryhl@google.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 12:52:37PM +0100, Jan Kara wrote:
> 
> Agreed. And just to demonstrate the point binder's use would become the
> first of such bugs because it is prone to the module being removed while
> the task work is in flight and thus do_close_fd() code can be freed by the
> time it gets executed.

Good point ...

> Generally, making some code modular usually requires more effort than just
> flipping the Kconfig to tristate. You usually need to make sure all objects
> and queued work is flushed before the module can be removed. Not sure how
> much of this is taken care of by Rust though...
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
