Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE732E2EE5
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318117; cv=none; b=UV5DRrjLIAhIa4BP7SV6brU6EVUiJL/Lu3B177ZzBh+o3FaOB6LNpR7rd2LmwznfGCk4KkkkvQRchPxorzhrCkfJ1oOUTKXYHK6f/PpmFP1WrIKo3/1F/csvajpio/hTuaUefqoOc8H2AeY8MGV7/ZUUx0KHtcEQnCZ5OrTlbdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318117; c=relaxed/simple;
	bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJrqDGluz1qN9zZCOcXC8nZa0DdtqDJUIczQKGV842vttyDo2Vt2dSc+EekY2dqIlfJfc5UcbN8Qrc+XyV16SRtd62UmvXg9ndxt1greMVcTVGU8LadjOGaaEzvdgRFdgi3Lj1S3VHKnCB8W0SMcsBlZf5ac+SxKdQ44EpWOhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRFydOo4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRFydOo4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5f6ad78e4so20202771cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 00:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757318114; x=1757922914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
        b=NRFydOo4a+6OwIXh8UmI+AY35mo9cFJsWY97DHtTXrHCg4Mp2paXDJTnLJ2ZNiwGII
         1y2eDt3vFot3b9VlcGXPSjNVk8/YkFLuxCHKQZ+q4J0Vrs3stYjtdp4mEJ0PQqVdZchU
         3A7+/fCph6kEzbk9XRLMs3L7kh6rrnXeLTEZAgrdNPtRnQ1XFUICGZ6vxhAwB3TDYljL
         GTPPSrtGB1GCrBqyDNpDFE7XJp1k1+0QbcXjrbY4xd89CcMFXl84eYYW7I9a9Gw46IBV
         UdGOw99U5ri7hlxeLQcCsxEbH6GNf9EskEY7+T+dKeh95uu3aUphmx1ve1tqKKf9Wj8M
         PKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318114; x=1757922914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMAdkEesf6bbVaFlUVQqYAa13fJGEFJLv/3W4iM237A=;
        b=LREt0eTrOYnBPxC3x82CFRuSExNDyo6/dguFn6vCJKO0/e3lgI0mwTSEzOmtwUyPqZ
         HiZCEfN9KbyB6mDsLF/F+1AEl5LDBHHBa3ej0IUWQhJwYVwML1PYCxyoEdPGRxUimsWG
         hULMoYSivsFllfEAJUfF24dmuz1ZnoDzlF0C3mhXRJiFxILK0P5KTnjU53L2cOj27kcp
         tt2F/8BNsIsdsyHHauQcO5e/RltMtYgigFwajA17mPQqFjmSDqQ8TrXrQLA2zyvtauZ5
         TrEzDciW1ZoioNnkue19U+1w1381V8Z3tHlkZhfI+pryLOTCxeXZRneIqD4SYPvEZ7vV
         Z5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWlulQc0CMjLFjghd/M8Kyk+R6B55jQDJuOTXrBoJaw8Xh9dWGpAcj7KjiWNN51ZkX+6t8HPKueYAymkiLWMMM0cdJ8zpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjcv8TEiZrJNQKC09MygRWvWuX1vuRVT0D0rWjahrHm3vL+qdN
	n3kiH76r1hkq69Vd7VNL5217fU6envTAT+A2faXpWCr3jFe4Y4rgNfy7pTyBDz/v/3XqBbNybE9
	t8kdgHZ08aqz081yG5qAjUTI0rTdNeG7KDEosgJYz
X-Gm-Gg: ASbGncvz0/PoyvIiwszvaW9YaAVVMvLlHVbT5L1z07jRSXMCu0L5qJQn9OqPe+mXaD3
	QkHwVBuLKWgNLChgUX6QzoSeKfAESa+cHCLwSFTqW76Iqs4OID0q33GO46hdzSrDsgtQyPMolMb
	Iryx/IYwqyL0eJ+l6P3fzPHAYJXEf5wxsC4v7Dmd13hofPEOKGe5w4i7tVw6T8I+HgQ4pTrtMgF
	Gy0tkoLX049GJB7VxdDPT/5
X-Google-Smtp-Source: AGHT+IE+DEtH3qbj8Gqg6gFy/3Z86KPShC5oG53QMgfLuSSWoagYTvVUj2zm9mak3D+Wg4ppn7vMjUWHj/IxZ7JsG5c=
X-Received: by 2002:a05:622a:285:b0:4b3:ca6b:fbaf with SMTP id
 d75a77b69052e-4b5f83b0d91mr63659271cf.26.1757318113799; Mon, 08 Sep 2025
 00:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908073238.119240-1-idosch@nvidia.com> <20250908073238.119240-3-idosch@nvidia.com>
In-Reply-To: <20250908073238.119240-3-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Sep 2025 00:55:02 -0700
X-Gm-Features: Ac12FXyjlgT2QbxcrAhtD0bWlIkl_fK9moFOPeDt0E03DmL9SoHOVj9Co8O5rrY
Message-ID: <CANn89iKir3_tS59i5ve=RKTgeOS6vRP_JLZyfkbFU0jRA_s_Zg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/8] ipv4: icmp: Pass IPv4 control block
 structure as an argument to __icmp_send()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, paul@paul-moore.com, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:35=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> __icmp_send() is used to generate ICMP error messages in response to
> various situations such as MTU errors (i.e., "Fragmentation Required")
> and too many hops (i.e., "Time Exceeded").
>
> The skb that generated the error does not necessarily come from the IPv4
> layer and does not always have a valid IPv4 control block in skb->cb.
>
> Therefore, commit 9ef6b42ad6fd ("net: Add __icmp_send helper.") changed
> the function to take the IP options structure as argument instead of
> deriving it from the skb's control block. Some callers of this function
> such as icmp_send() pass the IP options structure from the skb's control
> block as in these call paths the control block is known to be valid, but
> other callers simply pass a zeroed structure.
>
> A subsequent patch will need __icmp_send() to access more information
> from the IPv4 control block (specifically, the ifindex of the input
> interface). As a preparation for this change, change the function to
> take the IPv4 control block structure as an argument instead of the IP
> options structure. This makes the function similar to its IPv6
> counterpart that already takes the IPv6 control block structure as an
> argument.
>
> No functional changes intended.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
