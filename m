From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 16 May 2017 15:00:15 -0400
Subject: [Linux-ima-devel] [PATCH 0/7] IMA: new parser for
	ima_restore_measurement_list()
In-Reply-To: <20170516125347.10574-1-roberto.sassu@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
Message-ID: <4f5bc289-92cb-1ce2-4496-387efbb11769@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/16/2017 8:53 AM, Roberto Sassu wrote:
> A new IMA measurement list format, called Crypto Agile, will be introduced
> shortly to take full advantage of the algorithm flexibility of TPM 2.0.
> With the new format, it will be possible to provide for each list entry
> multiple digests, each calculated with an algorithm supported by the TPM.
> Those digests will be used by remote entities to verify the integrity of
> the measurements list.
> 
> The current (SHA1) and the new (Crypto Agile) format definitions are:
> 
> SHA1: pcr[4] digest[20]
>        template_name_len[4] template_name[template_name_len]
>        template_data_len[4] template_data[template_data_len]
> 
> Crypto Agile: pcr[4] total_digest_len[4]
>                digest1_len[4] digest1[digest1_len] ...
>                digestN_len[4] digestN[digestN_len]
>                template_name_len[4] template_name[template_name_len]
>                template_data_len[4] template_data[template_data_len]

1 - In this proposed format, how does the parser or consumer of the log
know what algorithm is used for digestN.
For example, the TCG standard format uses TPML_DIGEST_VALUES
	uint32_t count - the number of digests TPMT_HA
	TPMT_HA digests[]

where a TPMT_HA is
	algorithm identifier
	digest byte array

2 - Not a criticism, just a question for understanding ...  Would it be 
true that the total_digest_length == the sum of all the digestN_len 
values plus 4 bytes for each length.

Does it determine how many digests there are by when the total length is 
consumed?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
