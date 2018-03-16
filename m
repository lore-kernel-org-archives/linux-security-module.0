From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Fri, 16 Mar 2018 18:38:38 -0300
Subject: [PATCH v6 00/12] Appended signatures support for IMA appraisal
In-Reply-To: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
Message-ID: <87zi37og4h.fsf@morokweng.localdomain>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Now the modsig is only ignored if it references a signature that is not
> present in IMA's keyring (or if there's a parsing error, obviously). If the

The above should read "Now the modsig is only ignored if it references a
*key* that is not present in IMA's keyring".

Sorry, I only noticed the mistake after sending the emails.

--
Thiago Jung Bauermann
IBM Linux Technology Center

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
