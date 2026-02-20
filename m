Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53B2E63C
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584240; cv=none; b=qu4GUy7K8or52KPL4VYgkJvsMYq9p+DD8xs0d23wnJFnka9zEXXQmItUeEfSsLcmPJWlr+plhth7PQTTWi131ndpXf3QqniJUgHJlPYFKcgD8pjI7At++3Yd7aFeHIctOt9RM1sgGq7/MQe4MNd2VpwVRKrpU4m+MTR2F+Axh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584240; c=relaxed/simple;
	bh=6oat1xU8anNE+fKnMu7RuV5yY2BMoQVNebDQXBXTHyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qDPiAd4LyDvEPtXwBeDT40bCRxXIdN/AUuAvlMI7gwA4UUrwQo+fwp+rk/oDbXqLuZ+0x2tWzZ5q2oOy9zVHsD8gc1e06iPhrfjqgspTLzLArFox5FWEKEyjUXf5FOlHIiUNFDSK3w6QzG8MFXCoD/14eTLPYOz93v+gH1mARWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zx7VlbDB; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zx7VlbDB"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b885979bfa9so174626366b.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584238; x=1772189038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=159VoEA5XmeLqnnj1kbXT6hpp/0sD1qh3nTegzxwn4M=;
        b=Zx7VlbDBH1k04UAoGS92zbRtSEp0U+Kl7E0rx79M8A3M+MGPRdQwRYKTAWDB3V0hBK
         RRBQ39m2UWtqjSKIEfo06UZ+o/6N+Jy2aZ1w9d4TEgNmRDlFGqs5SZ371tD3MMGVmofd
         NCWOfrfsL8peSZ2qgx9o2z0qHHlc7ejygNop5WAVOnhI9j0s3nCbhZnd1gpxHNkjpQSi
         +BpJSgXlYZeZsAgzeBWbh1f9yV/Y0rXDUmIyEVOEpJGn8TxOdpMKnK8AV0cLxVncoi1e
         hBIPD08fSz6/smyWNEqFlzMUfYqwHVmDSC3W0q0gRJCW8SU3OGZ23vOoWzqnS8ABQ11k
         yrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584238; x=1772189038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=159VoEA5XmeLqnnj1kbXT6hpp/0sD1qh3nTegzxwn4M=;
        b=cJkiyv+GzHCq49GdJijBpC4ptLJ3byECe3vfYDuFeIk9hjnrSHkQrDMa5dBO2bGwya
         KALkIrDVBu1GHP/YB8HhCS6hAkRqzqnt3PtZeSNzSjO2V3t/QRpQ3nzTniZtVP12gPbI
         MFTioo9RJdGfx/GLbQLdGH5vyqlSv2RztijW5ifIq69s3KNMBCEhp0PL1skTD4RO6kee
         2TxvsuLQ86Td2hqbTpmr6pGacF3dQOTQL0uK3UYCC3SPBc3cufH+m5MIaAyUa90yP6av
         nbMF5SFaug8G2aYLyaoXvE74t9TmFUxoHdM/x/WeFmk5cIqGk/lWTZswrYmkZUjau820
         OIiw==
X-Forwarded-Encrypted: i=1; AJvYcCW0CNnBOGb++t4Fv1/GWwD2cjtMf3fkmaUR58urqooUxnj7Didz51RCbiyg9AJD9ha+Gz2QNsJCuEvEp5QjRCac4ksBukY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpbRzg24AHKXgLdrQSqUfirUGHnHoB/39SdA3yJVapzUhKT6IH
	tsR8gOElbTwBOktVo5vxNbnW0x+DwZDRUOrHhnqA6GCn+enfPPaU5XliLv+zwk/Jf1nqUKhgmp7
	ihXQ76ilJphS0BQt9Og==
X-Received: from ejcxl37.prod.google.com ([2002:a17:907:d865:b0:b8f:9da9:5701])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f586:b0:b87:daee:a6c4 with SMTP id a640c23a62f3a-b903dc9993cmr479899666b.36.1771584237418;
 Fri, 20 Feb 2026 02:43:57 -0800 (PST)
Date: Fri, 20 Feb 2026 10:43:56 +0000
In-Reply-To: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219-remove-task-euid-v1-1-904060826e07@google.com>
Message-ID: <aZg67K1Il3Dq3-Ap@google.com>
Subject: Re: [PATCH] task: delete task_euid()
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 19, 2026 at 12:14:39PM +0000, Alice Ryhl wrote:
>  include/linux/cred.h                                      |  1 -

I guess the title of this should probably be

	cred: delete task_euid()

rather than use the 'task:' prefix.

Alice
