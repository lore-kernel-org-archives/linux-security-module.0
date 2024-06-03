Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284C13D247
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454322; cv=none; b=GmZPi3ZiJMg7l+mTgkG1V0TDQh4slU2FO//AMQFUqgHdFNULWtksmrWGGbB0oNfcObaLcAZgj19PFC9lOBAwOXTThvXKpIzlbCpItMTiRG3jd25gLwvSyLaoxTRP705DSNHshS1LAB1+/3VkbIar3JLCz3B9J7fGCKiERCP4Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454322; c=relaxed/simple;
	bh=ADQ686y0LUmppB8hKb1UqpO0JQXUA06qEhc0vs+CvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+VcWWK/b8/mT7wr+uRegBeOyL9aqlsSkPJxcwL8KjLEZE/PnPGig46JPnPAuRNZo9wluYZQcSVL9yWNzxapCrXlT9mXyr6CD5pgRLU/Cliv2m30AuPLq6vNK33XPbTamI7XenL3730R2Dx9aDDRi3fnqYrsiIXaNOAud6fNCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GlLbdUhx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GlLbdUhx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b938587a4so2445219e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717454318; x=1718059118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=GlLbdUhxMOvfv07UbuQp52IzwdbLEpzUyMLKXMF+3Sd3FveyGQ9kiponRzzOcpMI6T
         emqgoJVIwu8WT9FqW+p07vqBAyXhgq+fwevyFcKUJiULsxWdobvwl8b48coCz7mCa9oe
         PdXEK+mV0+PmDWLF5beeySzOz0sai6fZmW68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454318; x=1718059118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=Ab1BnNQ5636AJum8EBPvZb1oQeX6J+tOg3cxFondXKS2qXhPjdZn412//FWYbXN8Uz
         oxFBXR8mfJyOOvAEn7gs6L4vThNoNJjE7dQU25ZZHErSCQwFEyqlx7m0tFusBpzPGfIj
         XdI1/KOAKIWMxzKNj+hEegh6yP69bx5xRT3H2PVr9SnrBfxhvtEp1T9c3FWOSVKDwG55
         NTkO/6XuxjECBJAN/fNXvcQwoPL4TrtWJCTllWdHXsHiz6Z6YwEBreush13MTGgaJ4cW
         g588C9MgTctdH774KC1Z3r8is5eWyLUvkRBRmnxG0lDeiNwcfXFFcvNfBD3/JFHq0JFA
         3NGg==
X-Forwarded-Encrypted: i=1; AJvYcCU+MIMZ84fwjPdXyElh1dKQSTbR+UE1CaWv++U3wEAnZuFES0V9NAsQ1JrxkL+HEUO2BCJg041gokFsgBCPH9ubx9ZUxMlCfyf9PntgGDU8jNXxsD3f
X-Gm-Message-State: AOJu0YxtL1cE2tPsoWniUEpXGK0RtrH6ROgpMFvIZbjOMdpNw64nf6Zj
	LUtyK/5yMmght1bn3HJozGKzpSuepPXm31Uw/7G/k50chaOe2/YjNu8DccW8KQ+NnYUjkb+LFPM
	72QqHpg==
X-Google-Smtp-Source: AGHT+IGejpC3mI4ed/A65flyoAPB7+6uk9TrYRYNdQJi2QDdQM3is0URJKnM4kmjSL2EbK0n+5mkzA==
X-Received: by 2002:a19:8c07:0:b0:51e:b5b6:29fb with SMTP id 2adb3069b0e04-52b8957850cmr6233181e87.21.1717454318498;
        Mon, 03 Jun 2024 15:38:38 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d87518sm1330675e87.234.2024.06.03.15.38.37
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b938587a4so2445193e87.1
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjslIpOuaOkJIN+gBt/f7qRnv3Ete+BiAQOTpn5zy0Dr7EkqYFy2srT7RBi8GWkhbZ2PC42+OooH89jjIgmqO2OG6wwNEASCwDc4DLXClkapk2rPU8
X-Received: by 2002:a05:6512:159a:b0:52b:9f37:3ec2 with SMTP id
 2adb3069b0e04-52b9f373f5fmr1374809e87.11.1717454316895; Mon, 03 Jun 2024
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's actually a 4 byte meta data that holds it.

Ok, much better.

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

Ok, as long as it's an actual improvement, then ack.

            Linus
