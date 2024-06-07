Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5526168DE
	for <linux-security-module@vger.kernel.org>; Fri,  7 Jun 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776483; cv=none; b=hYZeTJL+zs4bEKAygm5ss+Vum2D0P0zXNnjY7i56XUiNiKU7OYq7CHYOZYHs9ZDEHYzdVfJVR/IvUXfcIVacUAaOsUmlNGaRf0aHMDJwdmZO8dKHEwZNmi1MlJqUfzJMx7gBw55aPnagRnkcRIMcsC2VRCUWY/E+LPhGVM16wYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776483; c=relaxed/simple;
	bh=TxZ62lRbGYR0AmZpOp1164ij9xgmLaqHEpZwVrf2BUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjDGqazBDPIQpDVhnIDGDBYSFZPYtmg0QsA7Fy6WrWYZMuPlvpPAB8bUvBJ+dV5hi31pqybH9wB0jSN2s0ihP4kth/TJ42sE4PMpsSW+FlwqdwQ6P7DhcMJvcwmdu/sjuM4b06TD7K7LXKApgkf0MMEdBWtsIgmfPZm6hyRiDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFcKk1K2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFcKk1K2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717776480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBLE9WHJdPeMtGHEriSmKop5oZrT43bTfvmN1za5maQ=;
	b=VFcKk1K2yhj3KIgSFZrVrgS53o+gF4mhtZ7n3pmhag6v8mxSOz8o20QjK4LNgNVuUyqZ2X
	PxB69STQXkVdW6hZuRaQpLddFuAJKcf3yr5DZwBMaYp0c1EQqUa0AQZ/NCBJICe2OcUYhL
	wRVFfDoD6W0gtVSP7HR7v3EqY0hBq4U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-fNHHT38KOFWezd1Jxvdtzw-1; Fri, 07 Jun 2024 12:07:58 -0400
X-MC-Unique: fNHHT38KOFWezd1Jxvdtzw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a68f5c5f31eso130454866b.0
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2024 09:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776477; x=1718381277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBLE9WHJdPeMtGHEriSmKop5oZrT43bTfvmN1za5maQ=;
        b=Bp+/et+O6z2Dh1CedIEmuQQvPAOuMand0f9P5V5ri/mK9jyJxdqNp6cwbFYCztkGOO
         02O6hf+djfVhZozTMUOBzhb8NZML/7MESv/OrcQFU3YlyJT6Gm5VNLuvXHYovORlLeJ5
         dj+Fz5krveIV9lxoh5xabfUIqV4YSZIb+P2gNqI94J7DwjtyNyZV5awu7qpxEsfktCKo
         Hjjofr8bTv9SvLW79n3RBwMhGanmtUs7D8Ijkj0CsEz9vvE5/sgmuStsiNG5iDWPhbuH
         /ULu8tlbB000dZqn4uquO5UNcm1oV10p5F71QK6etMcJVr3rBpVA7FkwadnMRxR/OUut
         suFg==
X-Forwarded-Encrypted: i=1; AJvYcCX2AmQST4uTWcpaVic2AeqwdvdZMmwYeJccnzfZBHd1oH3eJnOzNc8mJJ0cR017J7p7ruEgAbwTMOSTvUm0Gsf+3lbACNB3bz5IjzpmsMtS10SjTpXM
X-Gm-Message-State: AOJu0YzEtuzCdQ9HEt5f1iTeduwGBWH8jmQ5wP/5uk2EQUXtjGPsmZ3B
	cNWTMtB5ZK84iFwBrN4wHp8lcF+w1U6ZpJOkO+IR3VxogjAKR1X4PLQFmYGqTKfXbMtQuXWG8h/
	FoBD3eSaxlplFxFG0MbB7YS3QuvieMSj34mhxaGFXkBRIjxZHC8zS9ABRU0L8zfjeP4D/zQuhtW
	tI4MVYQPz8
X-Received: by 2002:a17:906:f582:b0:a68:6032:463c with SMTP id a640c23a62f3a-a6cd65668b5mr284287166b.18.1717776477093;
        Fri, 07 Jun 2024 09:07:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuyKEHYo5TPUfVQg5eRCpyksPsAJrknMBehGQmuprA7HQfQFCf1RnS6OHoPTC28AUzT9y7uw==
X-Received: by 2002:a17:906:f582:b0:a68:6032:463c with SMTP id a640c23a62f3a-a6cd65668b5mr284284866b.18.1717776476606;
        Fri, 07 Jun 2024 09:07:56 -0700 (PDT)
Received: from telekom.ip (adsl-dyn127.78-99-32.t-com.sk. [78.99.32.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ebd59sm264672166b.116.2024.06.07.09.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:07:55 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
Date: Fri,  7 Jun 2024 18:07:51 +0200
Message-ID: <20240607160753.1787105-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This series aims to improve cipso_v4_skbuff_delattr() to fully
remove the CIPSO options instead of just clearing them with NOPs.
That is implemented in the second patch, while the first patch is
a bugfix for cipso_v4_delopt() that the second patch depends on.

Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
https://src.fedoraproject.org/tests/selinux/pull-request/488

Changes in v2:
- drop the paranoid WARN_ON() usage
- reword the description of the second patch

v1: https://lore.kernel.org/linux-security-module/20240416152913.1527166-1-omosnace@redhat.com/

Ondrej Mosnacek (2):
  cipso: fix total option length computation
  cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

 net/ipv4/cipso_ipv4.c | 75 +++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 21 deletions(-)

-- 
2.45.1

