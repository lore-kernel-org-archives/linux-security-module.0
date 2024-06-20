Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CE1AB91B
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890823; cv=none; b=GPukGD6c67bKQKdtlRRxwd2OfekyajOsz7hSVj4cXRPF3bzzu4fr8FmEkoIPXFXHE35wykHUhuDydjXSxIMFdt+Y7BCr23Tx3XvcMXfgpmrbnZtsUp2Qx/uLFrT76D7GRiYUs8NhoVh5rUq5GEW/9MEz9EznRN0Ywshta6RPMY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890823; c=relaxed/simple;
	bh=Q8QdvPizY1ZcV64zp0TGWeYn+Fg2XUF5OYlumUmLB5M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TwvE6x1FDvjO9+qF+XWlfX59JYiTVy3HPJQxarfDZE0jW4fNf+OPAOpVPmtg9bISAr10NqWTkMJaC+H/8fLL5HetbZo7UuKM0OaP7oT/4OXTQO1EtmA4PdxSZonQDDQzG0RBGutbXhkYgKCW6UUsAjDB4bMwT/LeMTUTci3AuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILrC15Ax; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILrC15Ax"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48c54370c56so281982137.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718890820; x=1719495620; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q8QdvPizY1ZcV64zp0TGWeYn+Fg2XUF5OYlumUmLB5M=;
        b=ILrC15Axd3YJ/d0Y9EPZGnqIC7AKhj2Za3AIH14hMMAgFoJEjIWoA3SrYuyvBMlt+b
         fBP7pCDf6ymfSmuXPe+bsPZZuDWk8JJjr4HKOx+oMXD6UgBEVzyNNCrA1N6XHjT/+T7s
         Ymp1KRtr2PzWQ37qAJFVz7tUMHL8wa43EMf+tAQr/asxwhKpW+uyEJ2mzmb4jdFqFblB
         cjM0WxSjxoTdiG5GKfyalLgkb5qa9mLZpeaS/aulqvzihmfvnm+rm2Xk1hMCMtl/HyWP
         LVHwjhvI2jS5ISip6s7LkIEkQneVEv58GX/ejibrD62b2GKDlRJAHivwctFk+mqdPhVZ
         e+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718890820; x=1719495620;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8QdvPizY1ZcV64zp0TGWeYn+Fg2XUF5OYlumUmLB5M=;
        b=w2Jix09144fEmf2c1HjcoJM5X4PaFU9Nqnu6BQ/IhGvqT/lUObMs2Rc1np9ppw3GMP
         cIbsRk80v1ouaFL2fPeZNVthiDBuX0Kpx6yEAS8tpOH6mNYw+82+J/PhN8fplBGpjz+2
         6wEOgKh2TIhOULnx9yyT++2xD3e/8+TK0yfu9XY4dcpCGBv4s6MM7ODrbeVG7yvve9Un
         7bcCJ4UDSyNwuxefOuU1QQNGxPKExqEE+vjBYjIkwyiJO9zXdZwv/BujTkqiMp0/87QB
         zyKLZBLgN/NFqtFdPit4Ktedb6OJKgaYO7XRYU9+RocZuUllq7g/URF/QsKsJXwfrbOi
         lQvw==
X-Gm-Message-State: AOJu0YwmV8sTs53DIy5MBO8lGvxwT8HN2BY7EL11jkFcX6o4k2GPbOn7
	fobhg3oLncMHDrJpcJEiTLoz3is6q2ku/Bv8lrpt6yzA7ktJEV7ii37A+OBKLIVAnY1zrRWc1r+
	cjafFXs+SaDblKV/MGNKLE6Red1zFF7EGcgU=
X-Google-Smtp-Source: AGHT+IEzRCRah0iazTQVakbVGuqVaxDs+1IZ1JSo1l5Uu64ht0qcYI1xpik4rqJYeuRczK0i+wQVAhhqwqQafz9KONY=
X-Received: by 2002:a67:f3c7:0:b0:48d:ca28:6579 with SMTP id
 ada2fe7eead31-48f13057725mr5666986137.18.1718890820289; Thu, 20 Jun 2024
 06:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Timur Chernykh <tim.cherry.co@gmail.com>
Date: Thu, 20 Jun 2024 16:40:09 +0300
Message-ID: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
Subject: Yet another vision of Linux security | Endpoint Security Framework
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

I'm here for yours' opinions.

The modern Linux, in fact, does not provide convenient options to
write AV/EDR software with real-time system events analysis as far as
unified system security events. For now we have only inconsistent
self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
cool technology, but even CO-RE sometimes works as not expected or
gets broken, for example:
https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
of a huge amount of the same hacks) looks a bit "crutchy".

As an EDR developer, I have an idea how to fix this situation, using a
unified endpoint security framework (ESF) placed in the kernel. Its
must:
- Provide unified and consistent security events;
- API to communicate with kernel:
 - To send program-defined events (as audit has);
 - Read events from kernel;
- Trusted agents delivery mechanisms (signing like kernel modules);
- Has a possibility to control what happens on system e.g block some
file operations, binary executions and so on;
- Has a portable and flexible events structure which doesn't get
broken from version to version;

For now I have PoC, which describes the concept in more detail:
GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
It contains all listed above points (maybe except portable event
structures)

There are an examples with:
- Security agent:
https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/samples/esf/agent.c
- API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/ctl.h
- Event structures and types:
https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/defs.h
- Main ESF source code:
https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/security/esf

Questions I'm interested in:
How does the community feel about this idea? Is it a viable concept?
If all is OK, what should I, as developer, do further? How much kernel
code outside the LSM module may be modified to keep further merge
acceptable? (currently not all LSM hooks meet to intercept all needed
data).

The general purpose is to make AV/EDR software development easier,
more convinient, and stable for Linux-based operating systems. This
PoC (as far as technology idea) is inspired by MacOS Endpoint Security
based on MAC policy.

Best regards,
Timur Chernykh,
Lead developer, F.A.C.C.T.
