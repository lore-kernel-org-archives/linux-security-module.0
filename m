Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004D1FDE31
	for <linux-security-module@vger.kernel.org>; Tue,  1 Apr 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508265; cv=none; b=nonlKkJRQT7lL79hnBW93pqfVPC4ooecTdFyhhHNT55y1YZqyvLZx3xz1YunEIv9fihKtraZFMeX7Al916yfD0fgJ4LN6PlFOTa22dGjamW7bQ/6sYtLv/5lpAmXwFcdXcKnGVhXtCmf9FU4LbVle8KVn7UclRohx26HfidXvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508265; c=relaxed/simple;
	bh=7lu+faxgJ+/AZ7tZp6LGCqh6omIcZni9UQEQ/b+J42g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DUN1pB6bqD/HGzyQ7pnXx8vAWO4CIgAmxncbfHZaCa5F04zZGKFQK6To8Bz5h6Zg6PtevRaOiW+kL7RWMgM5IDqohZVtsYEJCVYQhJgFxS3qyVHlV3pPiJJpkbdrxNHe/XhqGA36mCNpd1aJv7jdzwohio10CpkGOsOSTXAfvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzr0vbMQ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzr0vbMQ"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ac6caf952d7so493787066b.3
        for <linux-security-module@vger.kernel.org>; Tue, 01 Apr 2025 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743508262; x=1744113062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pBVgAem9FC0rH3wMYWeLDrWN3cdewUzW+os4Ei4bz0=;
        b=Pzr0vbMQbTM+uXPnScLFP/na/uODJXG1G40Pfu8tnTf87i4Fwg456dHGzm8QjsjvQ0
         q0Lr5F6nI2nQJo5lzWVPl5wWqOv8SDnUficI/sjz5FW3JnxVadnx1qWh1Nfa9JQsh0wE
         TqkK1IPZpk7gX8NHGmPENMWEnacI8qAr264eMLo6OFo3svdEkiV598auHX9MEmaQ9H3f
         K6PV52Fu/+hSSl69D/71DKHNtNv0oYbp/n2Wev24cY7wFwFkVWM2gzjTqerzBOw+Vjxg
         v759I0YpuR+6gtfvD6yZZxraDYWcDG8oTMSEdoOFQL8nGGx45jp8BLh7NHSxQO+f3tNm
         aYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508262; x=1744113062;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pBVgAem9FC0rH3wMYWeLDrWN3cdewUzW+os4Ei4bz0=;
        b=iInYK49EQNKsG4jvquv8jMDQDQY9OVr3/sAhw2uqBxDQkpaWMv5JqwQnrmK+CRVVL3
         M5R9qm3pCbH9XUWKcMchlMNjTiSp3eRi312EHeLb+Z/eaPEBjXolDRmPnSmiYvyS3/kK
         cO0huFGDNEjksgnLLvEMnACRAOdRF+Dt+1oCcydt5w1iPSO4QucdPfettccHosG5mrnG
         6wx10ouKHYCri87bcaElxLyncxxu6At6x1XpSJu9OGShef3pZB8/34hiSMM8X/BqM1Bu
         QL1nMXxXdJYzvx876TbSSoh+7eCvR/Lpl68vypOiGUALFt0W2TOoJ4vY4tOt1x1erjpB
         OuLw==
X-Gm-Message-State: AOJu0YxDDspbdXSDaCz1tZQ4l0spZ4U8MDqGmJpSYvRfpO959IZcXtyT
	DhIy/8cJMYv5EAwyeetx3d1wCX7JdH647eVvNoX5kYhcTdACEOhK4kbzNiAR2O4WFY5AOM0gJtX
	GwA==
X-Google-Smtp-Source: AGHT+IHdQDjFgga+BR8eXdMw0JGotQMidOuBAtmiwZSZB8obZpajOwyGV708iWH39BSofIXX0maNc93z9c0=
X-Received: from edty18.prod.google.com ([2002:aa7:ccd2:0:b0:5ea:8712:459a])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9693:b0:ac1:f003:be08
 with SMTP id a640c23a62f3a-ac73898d67dmr1181976766b.12.1743508262712; Tue, 01
 Apr 2025 04:51:02 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:51:00 +0000
In-Reply-To: <20250331104709.897062-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67e919bf.050a0220.1547ec.00a0.GAE@google.com> <20250331104709.897062-1-mic@digikod.net>
Message-ID: <Z-vTJPowPSqcBmmD@google.com>
Subject: Re: [PATCH v1] landlock: Remove incorrect warning
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, Paul Moore <paul@paul-moore.com>, 
	syzbot+8bca99e91de7e060e4ea@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:47:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> landlock_put_hierarchy() can be called when an error occurs in
> landlock_merge_ruleset() due to insufficient memory.  In this case, the
> domain's audit details might not have been allocated yet, which would
> cause landlock_free_hierarchy_details() to print a warning (but still
> safely handle this case).
>=20
> We could keep the WARN_ON_ONCE(!hierarchy) but it's not worth it for
> this kind of function, so let's remove it entirely.

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

-G=C3=BCnther
