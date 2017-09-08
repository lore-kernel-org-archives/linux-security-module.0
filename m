From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 8 Sep 2017 00:09:43 -0700
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <alpine.LRH.2.21.1709081448090.7880@namei.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
Message-ID: <20170908070943.GA26549@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The reason why I send out the original version of this patch
is because IMA used to call ->read under i_rwsem, and that deadlocked
on XFS and NFS, or ext3/4 with DAX.  The call path for that is

process_measurement (takes i_rwsem)
  -> ima_collect_measurement
    -> ima_calc_file_hash
       -> ima_calc_file_ahash / ima_calc_file_shash
         -> ima_calc_file_hash_atfm / ima_calc_file_hash_tfm
	   -> integrity_kernel_read

ima_check_last_writer (takes i_rwsem)
  -> ima_update_xattr
    -> ima_collect_measurement
       -> (as above)

But yes, for the init-time integrity_read_file this is incorrect.
It never tripped up, and I explicitly added the lockdep annotations
so that anything would show up, and it's been half a year since
I sent that first RFC patch..
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
