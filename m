Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF5DC77B7A
	for <linux-security-module@archiver.kernel.org>; Sun, 11 Jun 2023 11:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjFKLdF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Jun 2023 07:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjFKLdF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Jun 2023 07:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17ABD
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jun 2023 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686483136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fvk9nsOU+Ghrao8Fb/Dy7MlM3Rdl5iJgFNPzrlJhwHU=;
        b=cb0slUlB9XHYZycppz1P+AAtjD5cOIjef3KUegBF9g1G7kj+Rk2GQXyq1lwjTCxlXzn2vb
        rhqB7NHyQlLZB/118khBRqypj6duxtkJq/HsluZbCL8sXoNAVx2Leuz1jaGk5Reoo0mJwL
        Sj0cSSXxq0W1DlSukA8Veg4ioO94MEY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-9kFeoAzINXyqwlZD9ZlezQ-1; Sun, 11 Jun 2023 07:32:15 -0400
X-MC-Unique: 9kFeoAzINXyqwlZD9ZlezQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75eba2e48cfso248115485a.0
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jun 2023 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686483134; x=1689075134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvk9nsOU+Ghrao8Fb/Dy7MlM3Rdl5iJgFNPzrlJhwHU=;
        b=CmxHNkUS0+b0g4LA+FefL/5ApRRQmceFzvACbSY7AQT5cLvpX9VcjDYcRXxoFIvpM6
         rI48OQcCtDLPO+Jtk0tuKyhQ4VFsHXpKjXX+QL0pqRct289jPAcc0QV+FKZGaLX0gCby
         thwfPQN7NwtBONBrVoMZgNtqjHgqcSTuW9sUHuW2GCjeFqlbMPS/fd+pCe76vRgaqMGq
         sKgYoyc0ThS5cR5ZdMj38RD5aOSTLhy0tuxjcMbDQEBnkDqMHCzxhau9RRwKvFoV+bTn
         a1w8Y6x4xPoxws8qqhoTIx1Tur348aWHeD4ifLkJp8+Htm5B0fur6HbJYn8li3OxzfKz
         j0og==
X-Gm-Message-State: AC+VfDyUJR8z0bXLHwrKHJR84NpDIKohVl/MBkbqtCUrpj5HOyhhQzXo
        QcvIIUz0j+0+XVLsbvH1N3zZmpQ5GE4XxXP8lue64J38uiOwPIdw/0HYIOMlIUsOnJpa6hF13rB
        6QGucwxHwAZwDwMLY5T9Xy/EL5vPKNyleEA+p
X-Received: by 2002:a05:620a:4903:b0:75e:dbfa:e221 with SMTP id ed3-20020a05620a490300b0075edbfae221mr15325328qkb.20.1686483134729;
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vRb+f79/ygAXa3we8n0GBP8ylntMxHI3QIBUyoHCWYEcnmdtQzonemXCDV99sYqP6L8PJ1g==
X-Received: by 2002:a05:620a:4903:b0:75e:dbfa:e221 with SMTP id ed3-20020a05620a490300b0075edbfae221mr15325311qkb.20.1686483134522;
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z24-20020ae9c118000000b0074e0951c7e7sm2199166qki.28.2023.06.11.04.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 04:32:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] sysctl: set variable key_sysctls storage-class-specifier to static
Date:   Sun, 11 Jun 2023 07:32:10 -0400
Message-Id: <20230611113210.182652-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

smatch reports
security/keys/sysctl.c:12:18: warning: symbol
  'key_sysctls' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/keys/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
index b72b82bb20c6..b348e1679d5d 100644
--- a/security/keys/sysctl.c
+++ b/security/keys/sysctl.c
@@ -9,7 +9,7 @@
 #include <linux/sysctl.h>
 #include "internal.h"
 
-struct ctl_table key_sysctls[] = {
+static struct ctl_table key_sysctls[] = {
 	{
 		.procname = "maxkeys",
 		.data = &key_quota_maxkeys,
-- 
2.27.0

