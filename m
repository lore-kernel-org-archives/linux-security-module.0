From: dhowells@redhat.com (David Howells)
Date: Sat, 08 Sep 2018 16:26:14 +0100
Subject: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
In-Reply-To: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
References: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1809061007140.23269@namei.org>
Message-ID: <12101.1536420374@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote:

> so I have reviewed and tested this code. In addition, we have test cases for
> it in ELL (embedded linux library).

I wonder if there's any practical way to add a test for this to the keyutils
test suite.  I'm guessing it's quite tricky, given the extra bits you need to
emulate the TPM.

David
