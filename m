From: nayna@linux.vnet.ibm.com (Nayna)
Date: Thu, 6 Apr 2017 20:57:14 +0530
Subject: [tpmdd-devel] [RFC PATCH] tpm: msleep() delays - replace with
	usleep_range() in i2c nuvoton driver
In-Reply-To: <1487895987.3193.168.camel@linux.vnet.ibm.com>
References: <1487893578.3193.155.camel@linux.vnet.ibm.com>
	<20170224000051.GB19131@obsidianresearch.com>
	<1487895987.3193.168.camel@linux.vnet.ibm.com>
Message-ID: <58E65E52.8000304@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

We continued analyzing the msleep() behaviour. I tested running msleep() 
(without TPM interactions), by writing a kernel module that runs 
msleep() in a loop for a fixed number of iterations.

Based on these test results, as shown below, the observations are:

1. Non-cascading timers, as introduced by commit 500462a9de65, is 
working as expected, since all the timers expired well within ring 0.
2. However, the minimum delay doubled, causing the average delay to 
increase by ~30%.

CONFIG_HZ = 250:

For 1000 iterations, each of 1 msecs
=====================================

Kernel/Timer |       msleep          |    usleep_range      |

4.7          | Min: 4.89, Avg: 8     | Min: 1.12 Avg: 1.58  |
4.10         | Min: 11.9, Avg: 11.19 | Min: 1.31 Avg: 1.36  |


For 3000 iterations, each of 1 msecs.
=====================================

Kernel/Timer |        msleep         |    usleep_range     |

4.7          | Min: 6.55, Avg: 8.02  | Min: 1.05 Avg: 1.53 |
4.10         | Min: 11.8, Avg: 12.04 | Min: 1.02 Avg: 1.35 |


Thomas, can the minimum delay be improved ?

Thanks & Regards,
- Nayna


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
