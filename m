Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzC3Re4L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4B1BC
	for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dP5KrxTVSniSY5EKn+1whInNpNpKvz47uFsYRNbSIfU=;
	b=IzC3Re4LmlxC9yJ60ndTxGvVKRuHz/i2nyXi2yU3XS/NeWajuHCl0tKWMy6AzwfcMBkJR1
	4wzEnsToJr4Ty0GZRt8naAHXIfhwsedtyHCXm00DM/jfYWyYmpHuIhqilTrOVHKoZN5W2p
	+wRBDzSAEW9FNRYLIBXh11nCzyb8nI0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-i_7R4LylN8STr_1FrLDwdw-1; Tue, 28 Nov 2023 11:03:43 -0500
X-MC-Unique: i_7R4LylN8STr_1FrLDwdw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-333063a304fso1379654f8f.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Nov 2023 08:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187422; x=1701792222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP5KrxTVSniSY5EKn+1whInNpNpKvz47uFsYRNbSIfU=;
        b=qcgmT+PZIFaXo7/o+LWE1tREgtWpb5Rb3nA92FjD/pKt59MMc8Q48jOxPvBDEdrBR3
         83DAhkpoUeN4HQ75APQzz76emDypS06iuq7pyoDFX4xih0BGzASoWOEgzLfAHXZVopCd
         PhkoDIC+E4JDdfmLFfL4MSmxEm14lZlHFqJmzKH6OxEwRiMCK1b7CAJuLRouHXIQ6wRP
         zfubYVEQ4ojt59CTscWHt8tNFrqeX2QoF15EDMvhqv+Ydy9dmnjqbBLj0/+4YxlCaRNb
         zNbQySrZsbBBbqEXNiL6XqtVnnchQwMGump1kaaBjav2w4B0xREcOBaLq7661oqU1QkC
         unGw==
X-Gm-Message-State: AOJu0YydeFJemnQrc5t8ASWwzGKM/P2w2x6pZjWuS59Q8i0KaRyHML90
	0QueruvwXAcsbJ19A48fNPnW2rkSOpm7zxlEBZRmye4CzgS8+g7u+zyElc/lCMSZv2WbPjYSxRU
	qUPQvvZYv2fcsxCBYHGRTx2jbcPlbQYHrjama
X-Received: by 2002:adf:fdd2:0:b0:333:f42:da7c with SMTP id i18-20020adffdd2000000b003330f42da7cmr1411008wrs.12.1701187422421;
        Tue, 28 Nov 2023 08:03:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF0/vjcHQJgRjLn+YMRrmRzcBT/v6nI4n+3fYoa/+cVZ0kQZ66HeAXSc5ies1QQ/IS6vrEMA==
X-Received: by 2002:adf:fdd2:0:b0:333:f42:da7c with SMTP id i18-20020adffdd2000000b003330f42da7cmr1410984wrs.12.1701187422121;
        Tue, 28 Nov 2023 08:03:42 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:40 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 0/4] listmount changes
Date: Tue, 28 Nov 2023 17:03:31 +0100
Message-ID: <20231128160337.29094-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
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

This came out from me thinking about the best libc API.  It contains a few
changes that simplify and (I think) improve the interface. 

Tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git#vfs.mount
  commit 229dc17d71b0 ("listmount: guard against speculation")

Miklos Szeredi (4):
  listmount: rip out flags
  listmount: list mounts in ID order
  listmount: small changes in semantics
  listmount: allow continuing

 fs/namespace.c             | 93 +++++++++++++++-----------------------
 include/uapi/linux/mount.h | 13 ++++--
 2 files changed, 45 insertions(+), 61 deletions(-)

-- 
2.41.0

