Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101378;
	b=EbhIPrxEKjxSJfz+iFbhoTuS5JvFFjurXsekzrvDrsS+FjukwbclxLTV6zb6tdu77GAw
	 0b6dF483GrtjpocyN3rUow3OoBdOSzvF5Jv0UQBAd7k7+yqp/dCW0St/fsUSuL3VsbXbH
	 Dtpeicrm/j73ZM+6lC7QYifEyUBXwWyXPW9V4ectVfDlvLKH2fWZ+NyoQwZ/etVuMXMhH
	 aXTgdEaTbJ6UtdujaHKM52e3IZ7LTXYGrsH8kvaC40e8xJ8mxjw6pU0fXzA2ThdZyevf9
	 B+SAqqYVTObt+BQDqMWC4+BZv4qTJIOyhFxe64t3uKdZZCVsVnn7gE0qwhWJod+7EdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
	b=quWaOkWtsJVktBk5lzTyJz0IKahlAHKa/Ui2RyNXF71RPuL1Gf2uRHXmOKx/Fx8ofHa3
	 L2V/cgQYy9k1Ln0iR6634cBOTQXOid7VfMVIsRVcqsOK4yGgZpn70PJRqc7quwWLgYXs9
	 stK/DZudCdsTO0XAossGySyKu7NL177S4QfecA5VNK2a33ymE5aznuSicSYcgCfsF0Z7/
	 OPLRwLe201DKVIM1/o9runT/ABsoLk3UcZ2YeY6rHPJGLZXGTn0hLqyGA1xRYfFOrYr86
	 KppmqzttJ6RfmfYGJlPi7GDyhkbRJX0tV8Mg2PQ+Dwr6iUT9tVfarkZdzpIdrKitNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ELiSdUOH;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6C7606A330
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 11:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6C7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=ELiSdUOH
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2263598a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793101377; x=1793706177; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
        b=ELiSdUOH/cIJPyFJHbgZeLUlxA1ZsPoFOAPtjqLzx/rzQ9JO7MiO1l1EylHRSz9ezg
         ictUVQ2uhhQ2pYHxEdBrFH5HIDKQqTiAHMzqlnq5QD5CgC6J+EP2q6pJpZRC73jUwRhD
         ylqMz+7fKAuQWhpAwt6wJQNE9JgQDJ+tXRAss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793101377; x=1793706177;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IFKYyZe98olIOt/z7FVjqJN0LXwahHsaIWrhXMheXUY=;
        b=hq+ZthfALUlcGhvnOlxGKDuZd6NvwbVbisOWBTRKmDov01jjP80cZhWvgf3mQjZfuE
         jES5QCYlcndAgbdqbmK1scIAsWK1FYUMuHrUB8H2LHwRHef+U26RQL49cgmDJeUOpjov
         k1tgjJrcUWaQ2jYlkqPTxE2w0CjJeLkjSH7c8N6Rc22L7Nn3ayCb8fWA/oYj5Xno/IOl
         pRsCiP5QU58jHnTILd56pIcHCObfm+HOeTLDfjkKydbCsm+AxfURxGtRJ6Rr1BtNi0U2
         tYPlkYCiTEuZ9ibYrnXYvUtOqFCL0xdbn8b0X1cm4jY4Ukx5O6MPRV7bVdTErd1LgZxg
         ax7w==
X-Forwarded-Encrypted: i=1; AKwUvBzeZmWKBI4GNpbuNq+cMeORXyF+mhZMcMUUrGv4PjqOlCi6Z9clQu5Ff2qqIt9KLZ3dXCGxtE9oQtxKT7MJQYUDMnKW8P0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPoUVLbO4VrX0gfEb59eIhjv53QHcK/sNq4niEbU8mq/3x58Ch
	w14+zoKx5nyzn7badbsvQQYqmhLBUCU8xpwlpJ0VnOe4kiEMVPD9sN9wId2F8pmT6GU=
X-Gm-Gg: AYBFou2BC+9zUjUXjrBbKiveEgldzC7FjaRAzkmmd9MyV/m2vHyX/SlZim/b28fkV+J
	9Am3Y8cZB2rr9pEDU/tJYwSo2v3b97qpJQmXsVUC2KIjuDVFI9hQwd6tVF1J6c3uzsv6s6v51sW
	mbjop4sbOk/fjm0PInggVVDw5Z6IxXCDYVSyDGWRxS9CiLGKG2xOMMapWSYkjZfMzpRMgvo+naq
	xAqKlwEqdDageZuVV/crH7LHUq6+4PaSva1i/6XErqleU8759C4kpPH5hmPiWDS0BVLrkdCoEo8
	1Md8uQ+fTQRkcQuGI2ubwwWUQYwIn8CMCbKfYZMdcZkeotZc5iH6bNOxrjL7Ud1WIUkB+AEIU30
	5PydCCqYaGBNEmdoRHxsjL/DO5q2XxVPfgXI15V0ZU6OBeJNsYKdHxL+GMza2W8HS1YjMLyb2pV
	d2b2bpd9+6yhOYeFK55WSAB8FXx/9qG+rAuY/IDgFneIb3xQzBjkFVNxxHot1pvQKGgqGalJFXx
	p/sjaQCwTCzFtJ4sG6IQZl4Op0pwiE5tSZGq5CMLA+bKuhOIgzEL7ADN5f78tYR8Rl8JOwmuU0d
	dpE8xoGc3iL9hPt/+SeogBEiOz8b1YfJd7G7mhvC5kkqtnDqgrPc17yXoFwFoY4sRKkIAGFBuSE
	EpE0ShietfKs93OTBUG9gSbi8F5BHEMBhs9FI+472eosdmw5DbGeOBSR4E/oW1zky9/6S+PQW
X-Received: by 2002:a17:90a:d888:b0:3ac:80dc:f419 with SMTP id 98e67ed59e1d1-3adeae7309cmr8343178a91.25.1793101377141;
        Tue, 27 Oct 2026 04:42:57 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404426c2sm3637757a91.7.2026.10.27.04.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:42:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:42:54 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 0/3] mseal sysmap: Choose system mapping sealing at boot
Message-ID: <cover.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

System mapping sealing is currently a build time choice. Hosts which
want it and hosts which need to move or unmap these mappings therefore
need separate kernels, which is not ideal. Let's allow the administrator
to choose at boot time.

Chris Down (3):
  mseal sysmap: Add mseal_system_mappings= boot parameter
  mseal sysmap: Allow with CHECKPOINT_RESTORE, default off
  selftests/mseal_system_mappings: Test vdso unmap and remap

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/userspace-api/mseal.rst         |   5 +-
 include/linux/mm.h                            |   3 +-
 mm/mseal.c                                    |  13 +
 security/Kconfig                              |  17 +-
 .../selftests/mseal_system_mappings/Makefile  |   2 +
 .../selftests/mseal_system_mappings/config    |   2 +
 .../mseal_system_mappings/sysmap_is_sealed.c  | 236 ++++++++++++++++--
 8 files changed, 268 insertions(+), 17 deletions(-)


base-commit: bae9a042b03b27924c6fd5bdc00a20d6a44d6041
-- 
2.54.0

