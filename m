From: ztong@vt.edu (Tong Zhang)
Date: Tue, 25 Sep 2018 13:27:03 -0400
Subject: Leaking path for search_binary_handler
Message-ID: <C2D9C687-4964-4DB3-AAF4-7C836324D6BE@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kernel Version: 4.18.5

Problem Description:

search_binary_handler() should be called after setting bprm using prepare_binprm(),
and in prepare_binprm(), there?s a LSM hook security_bprm_set_creds(), 
which can make a decision that binfmt cares.

We found a leaking path In fs/binfmt_misc.c:235, that don?t ask LSM?s decision.

- Tong
